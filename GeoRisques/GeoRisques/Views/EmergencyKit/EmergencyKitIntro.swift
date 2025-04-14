import SwiftUI

struct EmergencyKitIntro: View {
    @Environment(EmergencyKitStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKitIntro = false

    var body: some View {
        @Bindable var store = store
        ZStack {
            TabView(selection: $store.infoIndex) {
                ForEach(store.kitInformation) { info in
                    VStack {
                        Spacer()

                        InfoCardView(kit: info)

                        Spacer()

                        if info == store.kitInformation.last {
                            ButtonView(text: LocalizedStringKey("intro_continue_button")) {
                                store.navigateToFamilyMembers.toggle()
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 48)
                        }
                    }
                    .tag(info.tag)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))

            if store.navigateToFamilyMembers {
                FamilyMember()
                    .background(Color(.systemBackground))
                    .transition(.opacity)
                    .zIndex(1)
            }
        } 
        .animation(.easeOut, value: store.navigateToFamilyMembers)
        .animation(.easeInOut, value: store.infoIndex)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .accent
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray6
        }
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    EmergencyKitIntro()
        .environment(emergencyKitStore)
}


struct InfoCardView: View {
    let kit: EmergencyKitInformation

    var body: some View {
        VStack(spacing: 16) {
            Image(kit.image)
                .resizable()
                .scaledToFit()
                .padding(32)

            Text(kit.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()

            Text(kit.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .padding()
    }
}


