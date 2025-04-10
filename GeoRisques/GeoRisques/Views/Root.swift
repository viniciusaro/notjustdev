import SwiftUI

struct RootView: View {
    @Environment(GeoRisquesStore.self) var store

    var body: some View {
        @Bindable var store = store
        
        TabView(
            selection: $store.rootState.selectedTab
        ) {
            RisquesView()
                .tabItem {
                    Label("Risques", systemImage: "light.beacon.max.fill")
                }
                .tag(GeoRisquesStore.Tab.risques)
            EmergencyKit()
                .tabItem {
                    Label("Kit d'Urgence", systemImage: "backpack.fill")
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
