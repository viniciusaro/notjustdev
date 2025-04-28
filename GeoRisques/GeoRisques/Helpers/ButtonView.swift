import SwiftUI

struct ButtonView: View {
    let text: LocalizedStringKey
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(text)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(.accent)
                .foregroundColor(.dark)
                .cornerRadius(50)
        }
    }
}
