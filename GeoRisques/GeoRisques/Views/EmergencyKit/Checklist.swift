import SwiftUI

struct Checklist: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        @Bindable var store = store

        NavigationStack() {
            VStack {
                TitleBarView(text: LocalizedStringKey("checklist_title"), label: "Famille", onTap: {
                    store.isShowingSheet = true
                })

                ShowChecklist()
            }
            .sheet(isPresented: $store.isShowingSheet) {
                FamilyMemberSheet()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    Checklist()
        .environment(emergencyKitStore)
}

struct ShowChecklist: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        ScrollView {
            if store.allAreZero() {
                    AlertView(
                        icon: "empty_backpack",
                        text: LocalizedStringKey("empty_state"),
                        frameSize: 170,
                        iconSize: 50,
                    )
            } else {
                EssentialKit()
                    .padding(.bottom, 24)
                if store.memberCount[.baby] ?? 0 != 0 {
                    BabyKit()
                        .padding(.bottom, 24)
                }
                if store.memberCount[.pet] ?? 0 != 0 {
                    PetKit()
                        .padding(.bottom, 24)
                }
            }
        }
    }
}

struct FamilyMemberSheet: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        VStack {
            TitleBarView(text: LocalizedStringKey("members_title"), label: "Terminer", onTap: {
                store.isShowingSheet = false
                store.saveFamilyMember()
            })
            .padding(.top, 24)

            ShowFamilyMemberView()

            if let selectedMember = store.selectedMember {
                CounterView(
                    onIncrement: { store.incrementMember(selectedMember) },
                    onDecrement: { store.decrementMember(selectedMember) }
                )
            }

            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct TitleBarView: View {
    let text: LocalizedStringKey
    let label: String
    let onTap: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .font(.title3)
                .bold()
            Spacer()
            Button(action: onTap) {
                Text(label)
            }
            .font(.body)
        }
        .padding(.bottom, 24)
    }
}

struct EssentialKit: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("essential_kit_title")).font(.title2).bold().padding(.bottom, 4)
            Text(LocalizedStringKey("kit_subtitle" )).padding(.bottom, 24)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitEssential()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: Text(item.localizedName),
                        isSelected: store.selectedEssentialItems.contains(item),
                        onTap: {
                            withAnimation {
                                if store.selectedEssentialItems.contains(item) {
                                    store.selectedEssentialItems.remove(item)
                                } else {
                                    store.selectedEssentialItems.insert(item)
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}

struct BabyKit: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("baby_kit_title")).font(.title2).bold().padding(.bottom, 4)
            Text(LocalizedStringKey("kit_subtitle")).padding(.bottom, 24)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitBaby()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: Text(item.localizedName),
                        isSelected: store.selectedBabyItems.contains(item),
                        onTap: {
                            withAnimation {
                                if store.selectedBabyItems.contains(item) {
                                    store.selectedBabyItems.remove(item)
                                } else {
                                    store.selectedBabyItems.insert(item)
                                }
                            }
                        }
                    )
                }
            }
        }
        .padding(.bottom, 24)
    }
}

struct PetKit: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("pet_kit_title")).font(.title2).bold().padding(.bottom, 4)
            Text(LocalizedStringKey("kit_subtitle")).padding(.bottom, 24)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitPet()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: Text(item.localizedName),
                        isSelected: store.selectedPetItems.contains(item),
                        onTap: {
                            withAnimation {
                                if store.selectedPetItems.contains(item) {
                                    store.selectedPetItems.remove(item)
                                } else {
                                    store.selectedPetItems.insert(item)
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}
