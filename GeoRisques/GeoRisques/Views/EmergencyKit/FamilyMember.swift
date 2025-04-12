import SwiftUI

struct FamilyMember: View {
    @Environment(EmergencyKitStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKit = false

    var body: some View {
        @Bindable var store = store

        NavigationStack {
                VStack() {
//                    TitleFamilyMember()

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(store.memberTypes, id: \.self) { member in
                            MemberView(
                                label: member.rawValue,
                                count: store.memberCount[member] ?? 0,
                                isSelected: store.selectedMember == member,
                                onTap: {
                                    withAnimation {
                                        store.selectedMember = (store.selectedMember == member ? nil : member)
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
                    OpenKitButtonView(text: "Préparer le kit d'urgence") {
                        if store.isKitButtonActive() {
                            store.saveFamilyMember()
                            hasSeenEmergencyKit = true
                        }
                    }
                    .padding(.bottom, 16)

                }
                .navigationTitle("Membres de la famille")
                .padding(.top, 16)
                .padding(.horizontal)
        }
    }
}

struct OpenKitButtonView: View {
    @Environment(EmergencyKitStore.self) var store
    let text: String
    let onTap: () -> Void


    var body: some View {
        Button(action: onTap) {
            Text(text)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    store.isKitButtonActive() ? .accent : Color(.systemGray6)
                )
                .foregroundColor(.dark)
                .cornerRadius(50)
        }
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
                .bold()
            Text("Créez votre kit d’urgence en fonction du nombre de membres de votre famille")
                .font(.body)

        }
        .padding(.bottom, 24)
    }
}


#Preview {
    let emergencyKitStore = EmergencyKitStore()

    FamilyMember()
        .environment(emergencyKitStore)
}

