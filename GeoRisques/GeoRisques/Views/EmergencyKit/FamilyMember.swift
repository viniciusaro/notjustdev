import SwiftUI

struct FamilyMember: View {
    @Environment(EmergencyKitStore.self) var store
    @AppStorage("hasSeenEmergencyKit") var hasSeenEmergencyKitIntro = false

    var body: some View {
        @Bindable var store = store

        NavigationStack() {
            VStack() {
                ShowFamilyMemberView()
                
                if let selectedMember = store.selectedMember {
                    CounterView(
                        onIncrement: { store.incrementMember(selectedMember) },
                        onDecrement: { store.decrementMember(selectedMember) }
                    )
                }
                
                Spacer()
                
                if !store.isShowingSheet {
                    OpenKitButtonView(text: LocalizedStringKey("start_kit_button")) {
                        if store.isKitButtonActive() {
                            store.saveFamilyMember()
                            store.navigateToChecklist = true
                            hasSeenEmergencyKitIntro = true
                        }
                    }
                    .padding(.bottom, 16)
                }
            }
            
            .navigationTitle(LocalizedStringKey("members_title"))
            .padding(.top, 16)
            .padding(.horizontal,16)
            .navigationDestination(isPresented: $store.navigateToChecklist) {
                Checklist()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}


#Preview {
    let emergencyKitStore = EmergencyKitStore()

    FamilyMember()
        .environment(emergencyKitStore)
}

struct ShowFamilyMemberView:View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        Text(LocalizedStringKey("members_subtitle"))
            .font(.body)
            .padding(.bottom, 24)

        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(store.memberTypes, id: \.self) { member in
                MemberView(
                    label: member.localizedName,
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
    }
}

struct OpenKitButtonView: View {
    @Environment(EmergencyKitStore.self) var store
    let text: LocalizedStringKey
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


