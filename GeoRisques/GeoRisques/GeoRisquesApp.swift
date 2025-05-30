import SwiftUI

@main
struct GeoRisquesApp: App {
    private var georisksStore = GeoRisksStore(
        locationClient: LiveLocationClient(),
        risksClient: LiveRisksClient(),
        openAIClient: OpenAIClientLive()
    )
    private var emergencyKitStore = EmergencyKitStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(georisksStore)
                .environment(emergencyKitStore)
        }
    }
}
