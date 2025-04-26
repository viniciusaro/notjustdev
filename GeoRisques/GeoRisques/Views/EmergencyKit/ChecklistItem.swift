import SwiftUI

struct ChecklistItem: View {
    @Environment(EmergencyKitStore.self) var store
    @Environment(\.colorScheme) var colorScheme

    let image: String
    let title: Text
    var isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? (colorScheme == .light ? Color(.accent).opacity(0.6) : Color(.accent)) : (colorScheme == .light ? Color(.systemGray6) : .white))
                .frame(height: 120)
                .overlay(
                    VStack(alignment:.leading) {
                        HStack {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                            Spacer()
                            ItemCheckbox(isChecked: isSelected)
                        }
                        .frame(height: 40)
                        .padding(.bottom, 12)
                        
                       title
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .bold()
                    }
                        .padding(16)
                )
        }
    }
}

struct ItemCheckbox: View {
    @Environment(\.colorScheme) var colorScheme
    var isChecked: Bool

    var body: some View {
        Button(action: {

        }) {
            Image(systemName: isChecked ? "checkmark.circle" : "circle")
                .font(.subheadline)
                .foregroundColor(isChecked ? .dark : (colorScheme == .light ? Color(.systemGray6) : .black))
                .imageScale(.large)
                .accessibilityLabel(isChecked ? "Décocher" : "Cocher")
        }
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

        HStack {
            ChecklistItem(
                image: "leash",
                title: Text("Leash"),
                isSelected: false,
                onTap: {
                },
            )
            ChecklistItem(
                image: "petToy",
                title: Text("Pet Toy"),
                isSelected: true,
                onTap: {
                },
            )
        }
        .environment(emergencyKitStore)
}
