import SwiftUI

struct EmergencyKit: View {
    @Environment(EmergencyKitStore.self) var store

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
                            ButtonView(text: "Générer la liste") {
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
                FamilyMembers()
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

struct InfoCardView: View {
    let kit: EmergencyKitInformation

    var body: some View {
        VStack(spacing: 16) {
            Image(kit.image)
                .resizable()
                .scaledToFit()
                .padding(32)

            Text(kit.title)
                .font(.title2)

            Text(kit.description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .padding()
    }
}


