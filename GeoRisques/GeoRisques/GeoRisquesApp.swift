import SwiftUI

@main
struct GeoRisquesApp: App {
    private var geoRisquesStore = GeoRisquesStore()
    private var emergencyKitStore = EmergencyKitStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(geoRisquesStore)
                .environment(emergencyKitStore)
        }
    }
}
