import SwiftUI

struct MemberView: View {
    let label: String
    let count: Int
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    count == 0 ? Color(.systemGray6) : (isSelected ? .accent : Color(.systemGray6))
                )
                .frame(height: 120)
                .overlay(
                    VStack {
                        Text("\(count)")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(
                                count == 0 ? .gray :
                                    (isSelected ? .dark : .accent)
                            )
                        Text(label)
                            .font(.body)
                            .foregroundColor(
                                count == 0 ? .gray :
                                    (isSelected ? .dark : .accent)
                            )
                    }
                )
        }
    }
}

