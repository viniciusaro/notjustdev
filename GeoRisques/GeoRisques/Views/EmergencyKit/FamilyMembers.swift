import SwiftUI

struct FamilyMembers: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        VStack() {
            VStack(spacing: 16) {
                Text("Membres de la famille")
                    .font(.title)
                Text("Créez votre kit d’urgence en fonction du nombre de membres de votre famille")
                    .font(.subheadline)

            }
            .padding(.bottom, 24)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(store.memberTypes, id: \.self) { member in
                    MemberView(
                        label: member.rawValue,
                        count: store.memberCount[member.rawValue] ?? 0,
                        isSelected: store.selectedMember == member.rawValue,
                        onTap: {
                            withAnimation {
                                store.selectedMember = (store.selectedMember == member.rawValue ? nil : member.rawValue)
                            }
                        }
                    )
                }
            }

            if let selectedMember = store.selectedMember {
                CounterView(
                    onIncrement: { store.incrementMember(selectedMember) },
                    onDecrement: { store.decrementMember(selectedMember) }
                )
            }

            Spacer()

            if store.memberCount.values.contains(where: { $0 > 0 }) {
                CreatCheckListButton {
                    store.saveFamilyMemberCount()
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal)
    }
}

struct CreatCheckListButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text("Générer la liste")
                .fontWeight(.bold)
                .frame(width: 200)
                .padding()
                .background(.accent)
                .foregroundColor(.dark)
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
                    .foregroundStyle(.accent)
                    .frame(width: 50, height: 40)
            }

            Divider().frame(height: 30)

            Button(action: onIncrement) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundStyle(.accent)
                    .frame(width: 50, height: 40)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.top, 30)
    }
}
