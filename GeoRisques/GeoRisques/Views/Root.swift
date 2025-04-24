import SwiftUI

struct RootView: View {
    @Environment(GeoRisquesStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @State private var isActive = false
    @State private var rotateLogo = false


    var body: some View {
        @Bindable var store = store

        if !hasSeenOnboarding {
            Onboarding()
        } else {
            TabView(
                selection: $store.rootState.selectedTab
            ) {
                RisquesView()
                    .tabItem {
                        Label(LocalizedStringKey("risk_tab"), systemImage: "light.beacon.max")
                    }
                    .tag(GeoRisquesStore.Tab.risques)
                if hasSeenEmergencyKit {
                    Checklist()
                        .tabItem {
                            Label(LocalizedStringKey("kit_tab"), systemImage: "backpack")
                        }
                        .tag(GeoRisquesStore.Tab.emergencyKit)
                } else {
                    EmergencyKitIntro()
                        .tabItem {
                            Label(LocalizedStringKey("kit_tab"), systemImage: "backpack")
                        }
                        .tag(GeoRisquesStore.Tab.emergencyKit)
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}

