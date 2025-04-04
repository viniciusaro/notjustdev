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
                    Label("Risques", systemImage: "list.bullet")
                }
                .tag(GeoRisquesStore.Tab.risques)
            ChecklistView()
                .tabItem {
                    Label("Checklist", systemImage: "square.and.arrow.up")
                }
                .tag(GeoRisquesStore.Tab.checklist)
        }
    }
}

#Preview {
    RootView()
        .environment(GeoRisquesStore())
}
