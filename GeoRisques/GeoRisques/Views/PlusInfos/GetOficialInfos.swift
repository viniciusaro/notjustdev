import SwiftUI

struct OficialInfos: View {
    @Environment(EmergencyKitStore.self) var store
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {

                VStack(spacing: 8) {
                    Text(LocalizedStringKey("oficialInfos-title"))
                        .font(.title)
                        .bold()
                    Text(LocalizedStringKey("oficialInfos-subtitle"))
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 24)
                
            VStack(spacing: 24) {
                ForEach(store.infoLinks) { info in
                    VStack(alignment: .leading, spacing: 16) {
                        ExternLinkButton(
                            colorScheme: _colorScheme,
                            frameHeight: 110,
                            image: info.image,
                            text: info.description) {
                                store.openExternalLinkFromString(info.url)
                            }
                    }
                }
                Spacer()
            }
            .padding(.horizontal,16)
        }
        .scrollIndicators(.hidden)
    }
    
}
#Preview {
    OficialInfos()
        .environment(EmergencyKitStore())
        .preferredColorScheme(.dark)
}
