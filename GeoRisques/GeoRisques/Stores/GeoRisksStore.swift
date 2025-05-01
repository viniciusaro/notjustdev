import MapKit
import SwiftUI
import Observation

@Observable
@MainActor
final class GeoRisksStore {
    var rootState: RootState
    var risksState: RisksState
    let locationClient: LocationClient
    let risksClient: RisksClient
    let openAIClient: OpenAIClient
    
    /// RiquesDetail Data
    var selectedRisk: Risk? = nil
    var aiResponse: String = ""
    var aiResponseIsLoading = false {
        didSet {
            if aiResponseIsLoading {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                        self.rotateRiskoLogo = true
                    }
                }
                rotateRiskoLogo = false
            }
        }
    }
    var rotationAngle: Double = 0
    var rotateRiskoLogo: Bool = false
    
    /// Rique Seach City Mapa Data
    var isEditing = false
    var searchCityText = ""
    
    init(
        rootState: RootState = RootState(),
        risksState: RisksState = RisksState(),
        locationClient: LocationClient = FixedLocationClient(location: .grenoble),
        risksClient: RisksClient = FixedRisksClient(risks: Risk.all, community: "GRENOBLE"),
        openAIClient: OpenAIClient = OpenAIClientMock()
    ) {
        self.rootState = rootState
        self.risksState = risksState
        self.locationClient = locationClient
        self.risksClient = risksClient
        self.openAIClient = openAIClient
    }
    
    enum Tab: Int {
        case risks
        case emergencyKit
        case plusInfos
    }
    
    struct RootState {
        var selectedTab: Tab = .risks
        
        init(selectedTab: Tab = .risks) {
            self.selectedTab = selectedTab
        }
    }
    
    struct RisksState {
        var risks: [Risk] = []
        var risksError: RisksClientError?
        var risksDescription: String = "..."
        var location: Location = .france
        var locationError: LocationClientError?
        var selectedRisks: RisksDetailState?
        var showLocationAlert: Bool = false
        var position: MapCameraPosition {
            get {
                return MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: location.latitudeDelta,
                            longitudeDelta: location.longitudeDelta,
                        )
                    )
                )
            }
            set {

                // Although this is a Binding, MapCameraPosition
                // does not allow reading location
                // information correctly.
                //
                // The correct way is by adding the [onMapCameraChange]
                // modifier to the view and then reading
                // the location manually.
                
            }
        }
    }
    
    //TODO: Verify is this struct is being used
    struct RisksDetailState: Equatable, Hashable {
        let risks: Risk
    }
    
    func onRisksDidLoad() {
        self.locationClient.start()
        Task {
            await reloadLocation()
            await reloadRisks()
        }
    }
    
    func onMapCameraCanged(_ context: MapCameraUpdateContext) {
        guard self.risksState.location != .france || self.risksState.locationError != nil else {
            return
        }
        
        self.risksState.location = Location(
            latitude: context.region.center.latitude,
            longitude: context.region.center.longitude,
            latitudeDelta: context.region.span.latitudeDelta,
            longitudeDelta: context.region.span.longitudeDelta,
        )
        Task {
            await reloadRisks()
        }
    }
    
    //TODO: Verify is this struct is being used
    func onRisksButtonTapped(_ risk: Risk) {
        self.risksState.selectedRisks = .init(risks: risk)
    }
    
    func onLocationButtonTapped() {
        if self.risksState.locationError != nil {
            self.risksState.showLocationAlert = true
            return
        }
        
        Task {
            await reloadLocation()
        }
    }
    
    func onLocationAlertDismisButtonTapped() {
        self.risksState.showLocationAlert = false
    }
    
    private func reloadLocation() async {
        do {
            let location = try await locationClient.location()
            await MainActor.run {
                self.risksState.location = location
            }
        } catch {
            self.risksState.locationError = (error as! LocationClientError)
        }
    }

    private func reloadRisks() async {
        do {
            let location = self.risksState.location
            let (risks, community) = try await risksClient.risks(at: location)
            self.risksState.risksError = nil
            self.risksState.risks = risks
            self.risksState.risksDescription = community ?? "(\(location.latitude), \(location.longitude))"
        } catch {
            // exit application if cast fails
            self.risksState.risksError = (error as! RisksClientError)
        }
    }
    
    func searchCity() {
        var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 45.19358632779559,
                longitude: 5.7153767705756655
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchCityText
        
        let search = MKLocalSearch(request: request)
           search.start { response, error in
               if let error = error {
                   print("Search error: \(error.localizedDescription)")
                   return
               }
               
               guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                   print("Location not found")
                   return
               }
               
               mapRegion.center = coordinate
               
               self.risksState.location = Location(
                   latitude: mapRegion.center.latitude,
                   longitude: mapRegion.center.longitude,
                   latitudeDelta: mapRegion.span.latitudeDelta,
                   longitudeDelta: mapRegion.span.longitudeDelta
               )
           }
    }
    
    func openExternalLink(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
    func totalOfRisks() -> Int {
        risksState.risks.count
    }
    
    //MARK: - AI
    func fetchAdvice(for risk: Risk) {
        let userLanguage = Locale.current
        aiResponseIsLoading = true
        aiResponse = ""
        let prompt = "Rédigez un résumé d'un paragraphe expliquant ce qu'est le risque de \(risk.name) et décrivez par étapes ce qu'il faut faire en cas de \(risk.name) dans la langue \(userLanguage), s'il vous plaît."
        
        Task {
            do {
                let advice = try await openAIClient.askAI(prompt: prompt)
                aiResponse = advice
            } catch {
                print("AI response error detailed: \(error.localizedDescription)")
                aiResponse = "\(LocalizedStringKey("ai-error-response"))"
            }
            aiResponseIsLoading = false
        }
    }
}
