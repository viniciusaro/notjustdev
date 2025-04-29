import SwiftUI

struct RiskoPrivacy: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(LocalizedStringKey("privacy-title"))
                    .font(.title)
                    .bold()
                
                Text(LocalizedStringKey("privacy-text"))
                .font(.body)
                .lineSpacing(5)
                
                Link(LocalizedStringKey("about-contact"),destination: URL(string: "mailto:iosappproduct@gmail.com")!)
                    .padding([.horizontal ], 16)
                    .frame(height: 48)
            }
            .padding(.horizontal, 24)
            Spacer()
        }
        .scrollIndicators(.hidden)
    }
    
}

#Preview {
    RiskoPrivacy()
}
