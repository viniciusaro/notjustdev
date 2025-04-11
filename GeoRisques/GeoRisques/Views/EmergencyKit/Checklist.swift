import SwiftUI

struct Checklist: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        ScrollView {
            VStack {
                ChecklistKitTitle()

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
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
    }
}


#Preview {
    let emergencyKitStore = EmergencyKitStore()

    Checklist()
        .environment(emergencyKitStore)
}

struct ChecklistKitTitle: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Kit d’urgence 72h")
                .font(.title)
                .bold()

            Text("Selectioner les articles que vous avez pour votre kit d’urgence")
                .font(.body)
        }
        .padding(.bottom, 16)
        .padding(.top, 8)
    }
}


struct EssentialKit: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]



    var body: some View {
        VStack(alignment: .leading) {
            Text("Les articles essentiels").font(.title2).bold().padding(.bottom, 16)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitEssential()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: item.rawValue,
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
            Text("Pour les bébés").font(.title2).bold().padding(.bottom, 16)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitBaby()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: item.rawValue,
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
            Text("Pour les animaux").font(.title2).bold().padding(.bottom, 16)
            LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitPet()) { item in
                    ChecklistItem(
                        image: item.imageName,
                        title: item.rawValue,
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

