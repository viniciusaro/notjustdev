import SwiftUI

struct RisqueDetailView: View {
    @Environment(GeoRisquesStore.self) var store

    var body: some View {
        @Bindable var store = store

        List(store.risquesState.risques, id: \.self) { risque in
            Button(action: {
                store.selectedRisque = risque
                store.fetchAdvice(for: risque)
            }) {
                ListRowView(iconName: risque.kind.imageName , risqueName: risque.name, arrowIcon: "chevron.right")
            }
        }
        .sheet(item: $store.selectedRisque) { risque in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ListRowView(iconName: risque.kind.imageName , risqueName: risque.name, arrowIcon: "")

                    Text(LocalizedStringKey("ai-name"))
                        .font(.footnote)
                        .bold()

                    VStack(alignment: .leading, spacing: 16) {
                        Text(LocalizedStringKey("ai-response-title"))
                            .font(.title2)
                            .bold()

                        Text(store.response)
                            .font(.body)
                            .lineSpacing(3.0)
                    }
                    .padding(.top, 24)
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .overlay {
                if store.isLoading {
                    RiskoLogo(rotationAngle: (store.rotateRiskoLogo ? 360 : 0))
                        .animation(.easeInOut(duration: 2), value: store.rotateRiskoLogo)
                }
            }
            .padding()
        }
        .onViewDidLoad {
            store.onRisquesDidLoad()
        }
    }
}

#Preview {
    RisqueDetailView()
        .environment(GeoRisquesStore())
        .environment(EmergencyKitStore())
}

struct ListRowView: View {
    @Environment(\.colorScheme) var colorScheme
    let iconName: String
    let risqueName: String
    let arrowIcon: String?

    var body: some View {
        HStack {
            Circle()
                .fill(.accent)
                .opacity(0.8)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                }
            Text(risqueName)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Spacer()
            Image(systemName: arrowIcon ?? "")
                .padding(.horizontal, 16)
        }
    }
}
