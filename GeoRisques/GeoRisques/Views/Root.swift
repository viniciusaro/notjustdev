import SwiftUI

struct RootView: View {
    @Environment(GeoRisquesStore.self) var store
    @State private var isActive = false
    @State private var rotateLogo = false
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false


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
                Image("risko")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .rotation3DEffect(
                        .degrees(rotateLogo ? 360 : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .animation(.easeInOut(duration: 1.5), value: rotateLogo)

                Text("Connaître les risques de catastrophes près de chez vous.")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .frame(width: 350)
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

