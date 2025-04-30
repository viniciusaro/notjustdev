import SwiftUI

struct AboutRisko: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(LocalizedStringKey("about-title"))
                    .font(.title)
                    .bold()
                
                Text(LocalizedStringKey("about-text"))
                    .font(.system(size: 18))
                .lineSpacing(5)
                
                Link(LocalizedStringKey("about-contact"),destination: URL(string: "mailto:iosappproduct@gmail.com")!)
                    .padding([.horizontal ], 16)
                    .frame(height: 48)
                
                Spacer()
                
                Link(LocalizedStringKey("about-help"),destination: URL(string: "https://buymeacoffee.com/meunomeecris")!)
                    .foregroundStyle(.accent)
                    .padding([.horizontal ], 24)
                    .frame(height: 48)
                    .background(.accent.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.bottom, 24)
            }
            .padding(.horizontal, 24)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AboutRisko()
}
