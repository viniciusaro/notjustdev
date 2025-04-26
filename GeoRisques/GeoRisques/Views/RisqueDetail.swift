import SwiftUI

struct RisqueDetailView: View {
    @Environment(GeoRisquesStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = store
        
        List(store.risquesState.risques, id: \.self) { risque in
            Button(action: {
                store.selectedRisque = risque
                store.fetchAdvice(for: risque)
            }) {
                ListRowView(
                    iconName: risque.kind.imageName,
                    risqueName: risque.name,
                    isArrowShowing: true
                )
            }
        }
        .listRowSpacing(12)
        .scrollIndicators(.hidden)
        .sheet(item: $store.selectedRisque) { risque in
            DetailsView(risque: risque)
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

struct DetailsView: View {
    @Environment(GeoRisquesStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    let risque: Risque
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                ListRowView(
                    iconName: risque.kind.imageName,
                    risqueName: risque.name,
                    isArrowShowing: false
                )
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .light ? Color(.systemGray6) : Color(.systemGray5))
                    .frame(height: 86)
                    .overlay(
                        HStack {
                            Button(action: {
                                store.openExternalLink(risque.reference)
                            }) {
                                HStack {
                                    Image("FrenchGov")
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 42, height: 42)
                                        .padding(.trailing, 12)
                                    
                                    Text(LocalizedStringKey("linkExtern"))
                                        .foregroundStyle(colorScheme == .light ? .black: .white)
                                        .multilineTextAlignment(.leading)
                                        .font(.subheadline)
                                        .bold()
                                }
                                Spacer()
                                Image(systemName: "chevron.right" )
                            }
                            .padding(.horizontal, 16)
                        }
                    )
                
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("ai-response-title"))
                        .font(.title2)
                        .bold()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.accent).opacity(0.2)
                        .frame(height: 55)
                        .overlay(
                            Text(LocalizedStringKey("ai-name"))
                                .foregroundStyle(.accent)
                                .font(.footnote)
                                .padding(8)
                        )
                        .padding(.bottom, 16)
                    
                    Text(store.response)
                        .font(.body)
                        .lineSpacing(3.0)
                }
            }
        }
        .scrollIndicators(.hidden)
        .overlay {
            if store.isLoading {
                RiskoLogo(rotationAngle: (store.rotateRiskoLogo ? 360 : 0))
            }
        }
        .padding()
    }
}

struct ListRowView: View {
    @Environment(GeoRisquesStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    let iconName: String
    let risqueName: String
    let isArrowShowing: Bool
    
    var body: some View {
        HStack {
            Circle()
                .foregroundStyle(colorScheme == .dark ? .accent : .accent)
                .opacity(colorScheme == .dark ? 0.9 : 0.5)
                .frame(width: 50, height: 50)
                .overlay(
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                )
            
            Text(risqueName)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            Spacer()
            if isArrowShowing {
                Image(systemName: "chevron.right" )
                    .padding(.horizontal, 16)
            }
        }
    }
}
