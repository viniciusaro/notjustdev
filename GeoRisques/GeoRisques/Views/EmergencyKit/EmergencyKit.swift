import SwiftUI

struct EmergencyKit: View {
    @Environment(EmergencyKitStore.self) var store
    private let dotAppearance = UIPageControl.appearance()

    var body: some View {
        @Bindable var store = store
        ZStack {
            TabView(selection: $store.infoIndex) {
                ForEach(store.kitInformation) { info in
                    VStack {
                        Spacer()
                        InfoCardView(kitInformation: info)
                        Spacer()

                        if info == store.kitInformation.last {
                            StartEmergencyKitButton(onTap: {
                                store.navigateToFamilyMembers.toggle()
                            })
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
                    .background(.white)
                    .transition(.opacity)
                    .zIndex(1)
            }
        } 
        .animation(.easeOut, value: store.navigateToFamilyMembers)
        .animation(.easeInOut, value: store.infoIndex)
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .blue
            dotAppearance.pageIndicatorTintColor = .systemGray6
        }
    }
}

struct InfoCardView: View {
    let kitInformation: EmergencyKitInformation

    var body: some View {
        VStack(spacing: 16) {
            Image(kitInformation.image)
                .resizable()
                .scaledToFit()
                .padding(32)

            Text(kitInformation.title)
                .font(.title2)
                .bold()

            Text(kitInformation.description)
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
        Button("Préparer le kit d'urgence") {
            onTap()
        }
        .fontWeight(.bold)
        .frame(width: 250)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(50)
    }
}



