import SwiftUI

struct RootView: View {
    @Environment(GeoRisksStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @State private var isSplashScreenActive = false
    @State private var rotateLogo = false


    var body: some View {
        @Bindable var store = store
        if isSplashScreenActive {
            if !hasSeenOnboarding {
                Onboarding()
            } else {
                TabView(
                    selection: $store.rootState.selectedTab
                ) {
                    RisksView()
                        .tabItem {
                            Label(LocalizedStringKey("risk_tab"), systemImage: "light.beacon.max")
                        }
                        .tag(GeoRisksStore.Tab.risks)
                    if hasSeenEmergencyKit {
                        Checklist()
                            .tabItem {
                                Label(LocalizedStringKey("kit_tab"), systemImage: "backpack")
                            }
                            .tag(GeoRisksStore.Tab.emergencyKit)
                    } else {
                        EmergencyKitIntro()
                            .tabItem {
                                Label(LocalizedStringKey("kit_tab"), systemImage: "backpack")
                            }
                            .tag(GeoRisksStore.Tab.emergencyKit)
                    }
                    Plus()
                        .tabItem {
                            Label(LocalizedStringKey("plus_tab"), systemImage: "info.circle.fill")
                        }
                        .tag(GeoRisksStore.Tab.plusInfos)
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
                    isSplashScreenActive = true
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environment(GeoRisksStore())
        .environment(EmergencyKitStore())
}

