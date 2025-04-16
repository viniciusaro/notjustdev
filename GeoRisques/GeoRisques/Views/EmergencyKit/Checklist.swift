import SwiftUI

struct Checklist: View {
    @Environment(EmergencyKitStore.self) var store
    
    var body: some View {
        @Bindable var store = store
        
        NavigationStack() {
            VStack {
                ShowChecklist()
            }
            .navigationTitle(LocalizedStringKey("checklist_title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink {
                        FamilyMember()
                    } label: {
                        Text(LocalizedStringKey("open_family_button"))
                            .font(.body)
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
        }
        .onAppear {
            store.navigateToChecklist = false
        }
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
            EssentialKit()
                .padding([.top, .bottom], 24)
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


