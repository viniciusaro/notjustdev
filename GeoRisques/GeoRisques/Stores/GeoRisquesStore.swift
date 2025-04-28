import MapKit
import SwiftUI
import Observation

@Observable
final class GeoRisquesStore {
    var rootState: RootState
    var risquesState: RisquesState
    let locationClient: LocationClient
    let risquesClient: RisquesClient
    let openAIClient: OpenAIClient
    
    /// RiquesDetail Data
    var selectedRisque: Risque? = nil
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
        risquesState: RisquesState = RisquesState(),
        locationClient: LocationClient = FixedLocationClient(location: .grenoble),
        risquesClient: RisquesClient = FixedRisquesClient(risques: Risque.all, community: "GRENOBLE"),
        //TODO: Put back OpenAIClientLive()
        openAIClient: OpenAIClient = OpenAIClientMock()
    ) {
        self.rootState = rootState
        self.risquesState = risquesState
        self.locationClient = locationClient
        self.risquesClient = risquesClient
        self.openAIClient = openAIClient
    }
    
    enum Tab: Int {
        case risques
        case emergencyKit
    }
    
    struct RootState {
        var selectedTab: Tab = .risques
        
        init(selectedTab: Tab = .risques) {
            self.selectedTab = selectedTab
        }
    }
    
    struct RisquesState {
        var risques: [Risque] = []
        var risquesError: RisquesClientError?
        var risquesDescription: String = "..."
        var location: Location = .france
        var locationError: LocationClientError?
        var selectedRisque: RisqueDetailState?
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
    struct RisqueDetailState: Equatable, Hashable {
        let risque: Risque
    }
    
    func onRisquesDidLoad() {
        Task {
            await reloadLocation()
            await reloadRisques()
        }
    }
    
    func onMapCameraCanged(_ context: MapCameraUpdateContext) {
        guard self.risquesState.location != .zero else {
            return
        }
        
        self.risquesState.location = Location(
            latitude: context.region.center.latitude,
            longitude: context.region.center.longitude,
            latitudeDelta: context.region.span.latitudeDelta,
            longitudeDelta: context.region.span.longitudeDelta,
        )
        Task {
            await reloadRisques()
        }
    }
    
    //TODO: Verify is this struct is being used
    func onRisqueButtonTapped(_ risque: Risque) {
        self.risquesState.selectedRisque = .init(risque: risque)
    }
    
    func onLocationButtonTapped() {
        if self.risquesState.locationError == .unauthorized {
            self.risquesState.showLocationAlert = true
        }
        
        Task {
            await reloadLocation()
            await reloadRisques()
        }
    }
    
    func onLocationAlertDismisButtonTapped() {
        self.risquesState.showLocationAlert = false
    }
    
    private func reloadLocation() async {
        do {
            let location = try await locationClient.location()
            withAnimation {
                self.risquesState.location = location
            }
        } catch {
            // exit application if cast fails
            self.risquesState.locationError = (error as! LocationClientError)
        }
    }
    
    private func reloadRisques() async {
        do {
            let location = self.risquesState.location
            self.risquesState.risquesError = nil
            let (risques, community) = try await risquesClient.risques(at: location)
            self.risquesState.risques = risques
            self.risquesState.risquesDescription = community ?? "(\(location.latitude), \(location.longitude))"
        } catch {
            // exit application if cast fails
            self.risquesState.risquesError = (error as! RisquesClientError)
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
               
               self.risquesState.location = Location(
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
        risquesState.risques.count
    }
    
    //MARK: - AI
    func fetchAdvice(for risque: Risque) {
        let userLanguage = Locale.current
        aiResponseIsLoading = true
        aiResponse = ""
        let prompt = "Rédigez un résumé d'un paragraphe expliquant ce qu'est le risque de \(risque.name) et décrivez par étapes ce qu'il faut faire en cas de \(risque.name) dans la langue \(userLanguage), s'il vous plaît."
        
        Task {
            do {
                let advice = try await openAIClient.askAI(prompt: prompt)
                aiResponse = advice
            } catch {
                print("Error detailed: \(error.localizedDescription)")
                aiResponse = "\(LocalizedStringKey("ai-error-response"))"
            }
            aiResponseIsLoading = false
        }
    }
}
