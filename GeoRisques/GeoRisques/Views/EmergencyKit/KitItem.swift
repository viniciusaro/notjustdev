import SwiftUI

struct KitItemView: View {
    @Environment(EmergencyKitStore.self) var store
    @Environment(\.colorScheme) var colorScheme

    let image: String
    let title: String
    var isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? .accent : (colorScheme == .light ? Color(.systemGray6) : .white))
                .frame(height: 150)
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

                        Text("\(title)")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(isSelected ? .dark : .black)
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
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundColor(isChecked ? .dark : (colorScheme == .light ? Color(.systemGray6) : .white))
                .imageScale(.large)
                .accessibilityLabel(isChecked ? "Décocher" : "Cocher")
        }
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    HStack {
        KitItemView(
            image: "lampe",
            title: "Eau potable en bouteille",
            isSelected: false,
            onTap: {
            },
        )
        KitItemView(
            image: "lampe",
            title: "Lampe de poche",
            isSelected: true,
            onTap: {},
        )
        KitItemView(
            image: "lampe",
            title: "Corde",
            isSelected: true,
            onTap: {},
        )
    }
    .environment(emergencyKitStore)
}
