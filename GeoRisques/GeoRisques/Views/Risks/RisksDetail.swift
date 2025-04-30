import SwiftUI

struct RisksDetailView: View {
    @Environment(GeoRisksStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        @Bindable var store = store
        
        List(store.risksState.risks, id: \.self) { risk in
            Button(action: {
                store.selectedRisk = risk
                store.fetchAdvice(for: risk)
            }) {
                RisksListRow(
                    iconName: risk.kind.imageName,
                    riskName: risk.name,
                    isArrowShowing: true
                )
            }
        }
        .listRowSpacing(12)
        .scrollIndicators(.hidden)
        .sheet(item: $store.selectedRisk) { risk in
            DetailView(risk: risk)
        }
        .onViewDidLoad {
            store.onRisksDidLoad()
        }
    }
}

#Preview {
    RisksDetailView()
        .environment(GeoRisksStore())
        .environment(EmergencyKitStore())
}

struct DetailView: View {
    @Environment(GeoRisksStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    let risk: Risk
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 40) {
                RisksListRow(
                    iconName: risk.kind.imageName,
                    riskName: risk.name,
                    isArrowShowing: false
                )
                ///Link Gov
                ExternLinkButton(
                    colorScheme: _colorScheme,
                    frameHeight: 72,
                    image: "FrenchGov",
                    text: LocalizedStringKey("linkExtern")) {
                        store.openExternalLink(risk.reference)
                    }
                ///AI Response
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
                    
                    Text(store.aiResponse)
                        .font(.system(size: 18))
                        .lineSpacing(3.0)
                }
            }
        }
        .scrollIndicators(.hidden)
        .overlay {
            if store.aiResponseIsLoading {
                RiskoLogo(rotationAngle: (store.rotateRiskoLogo ? 360 : 0))
            }
        }
        .padding()
    }
}


