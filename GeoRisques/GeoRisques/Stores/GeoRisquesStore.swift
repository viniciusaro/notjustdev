import MapKit
import SwiftUI
import Observation

@Observable
final class GeoRisquesStore {
    var rootState: RootState
    var risquesState: RisquesState
    let locationClient: LocationClient
    let risquesClient: RisquesClient
    
    init(
        rootState: RootState = RootState(),
        risquesState: RisquesState = RisquesState(),
        locationClient: LocationClient = FixedLocationClient(location: .grenoble),
        risquesClient: RisquesClient = FixedRisquesClient(risques: Risque.all),
    ) {
        self.rootState = rootState
        self.risquesState = risquesState
        self.locationClient = locationClient
        self.risquesClient = risquesClient
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
        var error: Error?
        var location: Location = .zero
        var selectedRisque: RisqueDetailState?
        
        var position: MapCameraPosition {
            get {
                return MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: location.latitude,
                            longitude: location.longitude
                        ),
                        span: MKCoordinateSpan(
                            latitudeDelta: location.delta,
                            longitudeDelta: location.delta
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
    
    struct RisqueDetailState: Equatable, Hashable {
        let risque: Risque
    }
    
    func onRisquesDidLoad() {
        Task {
            await reloadLocation()
            await reloadRisques()
        }
    }
    
    func onRisqueButtonTapped(_ risque: Risque) {
        self.risquesState.selectedRisque = .init(risque: risque)
    }
    
    func onLocationButtonTapped() {
        Task {
            await reloadLocation()
            await reloadRisques()
        }
    }
    
    func onMapCameraChange(_ region: MKCoordinateRegion) {
        self.risquesState.location = Location(
            latitude: region.center.latitude,
            longitude: region.center.longitude,
            delta: region.span.latitudeDelta
        )
        Task {
            await reloadRisques()
        }
    }
    
    private func reloadLocation() async {
        do {
            let location = try await locationClient.location()
            withAnimation {
                self.risquesState.location = location
            }
        } catch {
            self.risquesState.error = error
        }
    }
    
    private func reloadRisques() async {
        do {
            let location = self.risquesState.location
            self.risquesState.risques = try await risquesClient.risques(at: location)
        } catch {
            self.risquesState.error = error
        }
    }
}
