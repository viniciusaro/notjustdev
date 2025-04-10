import SwiftUI

@main
struct GeoRisquesApp: App {
    private var geoRisquesStore = GeoRisquesStore(
        locationClient: LiveLocationClient(),
        risquesClient: LiveRisquesClient()
    )
    private var emergencyKitStore = EmergencyKitStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(geoRisquesStore)
                .environment(emergencyKitStore)
        }
    }
}
