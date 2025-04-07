import SwiftUI

struct FamilyMembers: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        VStack() {
            Text("Membres de la famille")
                .font(.title)
                .bold()

            Text("Créez votre kit d’urgence en fonction du nombre de membres de votre famille")
                .font(.body)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(store.memberTypes, id: \.self) { label in
                    MemberView(
                        label: label,
                        count: store.memberCount[label] ?? 0,
                        isSelected: store.selectedMember == label,
                        onTap: {
                            withAnimation {
                                store.selectedMember = (store.selectedMember == label ? nil : label)
                            }
                        }
                    )
                }
            }

            if let selectedLabel = store.selectedMember {
                CounterView(
                    onIncrement: { store.increment(selectedLabel) },
                    onDecrement: { store.decrement(selectedLabel) }
                )
            }

            Spacer()

            if store.memberCount.values.contains(where: { $0 > 0 }) {
                CreatCheckListButton {
                    store.save()
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    FamilyMembers()
}


struct CreatCheckListButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text("Générer la liste")
                .fontWeight(.bold)
                .frame(width: 200)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
        .padding(.bottom, 24)
    }
}


struct CounterView: View {
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack(spacing: 40) {
            Button(action: onDecrement) {
                Image(systemName: "minus")
                    .font(.title)
                    .frame(width: 50, height: 40)
            }

            Divider().frame(height: 30)

            Button(action: onIncrement) {
                Image(systemName: "plus")
                    .font(.title)
                    .frame(width: 50, height: 40)
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(12)
        .padding(.top, 30)
    }
}
