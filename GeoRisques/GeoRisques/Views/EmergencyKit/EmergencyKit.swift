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
                            StartEmergencyKitButton {
                                store.navigateToFamilyMembers.toggle()
                            }
                        }
                        Spacer()
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
                .padding(.horizontal, 24)
        }
        .padding()
    }
}


struct StartEmergencyKitButton: View {
    let onTap: () -> Void

    var body: some View {
        Button("Préparer le kit d'urgence", action: onTap)
        .fontWeight(.bold)
        .frame(width: 250)
        .padding()
        .background(.accent)
        .foregroundColor(.dark)
        .cornerRadius(50)
    }
}



