import SwiftUI

struct RootView: View {
    @Environment(GeoRisquesStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false

    var body: some View {
        @Bindable var store = store

        TabView(
            selection: $store.rootState.selectedTab
        ) {
            RisquesView()
                .tabItem {
                    Label("Risques", systemImage: "light.beacon.max")
                }
                .tag(GeoRisquesStore.Tab.risques)

            if hasSeenEmergencyKit {
                Checklist()
                    .tabItem {
                        Label("Kit d'Urgence", systemImage: "backpack")
                    }
                    .tag(GeoRisquesStore.Tab.emergencyKit)
            } else {
                EmergencyKitIntro()
                    .tabItem {
                        Label("Kit d'Urgence", systemImage: "backpack")
                    }
                    .tag(GeoRisquesStore.Tab.emergencyKit)
            }
        }
    }
}

#Preview {
    RootView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}
