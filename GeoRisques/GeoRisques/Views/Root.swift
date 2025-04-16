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
                    Label(LocalizedStringKey("risk_tab"), systemImage: "light.beacon.max")
                }
                .tag(GeoRisquesStore.Tab.risques)
            Checklist()
                .tabItem {
                    Label(LocalizedStringKey("kit_tab"), systemImage: "backpack")
                }
                .tag(GeoRisquesStore.Tab.emergencyKit)
        }
    }
}

#Preview {
    RootView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}
