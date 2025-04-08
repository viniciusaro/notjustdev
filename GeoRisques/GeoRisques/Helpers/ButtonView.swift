import SwiftUI

struct ButtonView: View {
    let text: String
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
