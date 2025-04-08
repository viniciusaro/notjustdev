import SwiftUI

struct FamilyMembers: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        VStack() {
            TitleFamilyMember()

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(store.memberTypes, id: \.self) { member in
                    MemberView(
                        label: member.rawValue,
                        count: store.memberCount[member.rawValue] ?? 0,
                        isSelected: store.selectedMember == member.rawValue,
                        onTap: {
                            withAnimation {
                                store.tapMember(member.rawValue)
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
                ButtonView(text: "Préparer le kit d'urgence") {
                    store.saveFamilyMember()
                }
                .padding(.bottom, 16)
            }
        }
        .padding(.top, 16)
        .padding(.horizontal)
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


struct TitleFamilyMember: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Membres de la famille")
                .font(.title)
            Text("Créez votre kit d’urgence en fonction du nombre de membres de votre famille")
                .font(.subheadline)

        }
        .padding(.bottom, 24)
    }
}

