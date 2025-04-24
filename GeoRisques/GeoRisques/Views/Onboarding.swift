import SwiftUI

struct Onboarding: View {
    @Environment(EmergencyKitStore.self) var store
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false

    var body: some View {
        @Bindable var store = store
        ZStack {
            TabView(selection: $store.onboardingIndex) {
                ForEach(store.onboardingInformation) { info in
                    VStack {
                        Spacer()

                        InfoCardView(kit: info)

                        Spacer()

                        if info == store.onboardingInformation.last {
                            ButtonView(text: LocalizedStringKey("onboarding_button")) {
                                store.navigateToRisque = true
                                hasSeenOnboarding = true
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

            if store.navigateToRisque {
                RisquesView()
                    .background(Color(.systemBackground))
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeOut, value: store.navigateToRisque)
        .animation(.easeInOut, value: store.onboardingIndex)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .accent
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray6
        }
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    Onboarding()
        .environment(emergencyKitStore)
}
