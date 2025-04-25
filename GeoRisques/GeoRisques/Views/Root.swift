import SwiftUI

struct RootView: View {
    @Environment(GeoRisquesStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false
    @State private var isActive = false
    @State private var rotateLogo = false


    var body: some View {
        @Bindable var store = store

        if isActive {
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
        } else {
            VStack {
                RiskoLogo(rotationAngle: (rotateLogo ? 360 : 0))
                    .animation(.easeInOut(duration: 1.5), value: rotateLogo)

                Text(LocalizedStringKey("splach_screen"))
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .frame(width: 300)
            }
            .onAppear {
                rotateLogo = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
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

