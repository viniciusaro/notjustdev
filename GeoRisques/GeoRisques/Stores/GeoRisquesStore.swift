import MapKit
import SwiftUI
import Observation

#if DEBUG
var risquesClient = FixedRisquesClient(risques: Risque.naturalDisasters)
var locationClient = FixedLocationClient(location: .grenoble)
#else
let risquesClient = LiveRisquestClient()
let locationClient = LiveLocationClient()
#endif

@Observable
final class GeoRisquesStore {
    var rootState: RootState
    var risquestState: RisquestState
    
    init(
        rootState: RootState = RootState(),
        risquestState: RisquestState = RisquestState()
    ) {
        self.rootState = rootState
        self.risquestState = risquestState
    }
    
    enum Tab: Int {
        case risques
        case checklist
    }
    
    struct RootState {
        var selectedTab: Tab = .risques
        
        init(selectedTab: Tab = .risques) {
            self.selectedTab = selectedTab
        }
    }
    
    struct RisquestState {
        var risques: [Risque] = []
        var error: Error?
        var position: MapCameraPosition = .automatic
        
        var location: Location {
            return Location(
                latitude: position.region?.center.latitude ?? 0,
                longitude: position.region?.center.longitude ?? 0
            )
        }
    }
    
    func onRisquesDidLoad() {
        Task {
            do {
                let location = try await locationClient.location()
                self.risquestState.position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.05,
                            longitudeDelta: 0.05
                        )
                    )
                )
                self.risquestState.risques = try await risquesClient.risques(at: location)
            } catch {
                self.risquestState.error = error
            }
        }
    }
    
    func onRisqueButtonTapped(_ risque: Risque) {
        
    }
    
    func onLocationButtonTapped() {
        
    }
}
