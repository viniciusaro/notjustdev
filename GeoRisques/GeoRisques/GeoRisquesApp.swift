import SwiftUI

@main
struct GeoRisquesApp: App {
    private var store = GeoRisquesStore()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
    }
}
