import SwiftUI

struct KitChecklist: View {
    @Environment(EmergencyKitStore.self) var store

    var body: some View {
        ScrollView {
            VStack {
                KitEssentiaView()
                    .padding([.top, .bottom], 24)
                KitBabyView()
                    .padding(.bottom, 24)
                KitPetView()
                    .padding(.bottom, 24)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 16)
    }
}

#Preview {
    let emergencyKitStore = EmergencyKitStore()

    KitChecklist()
        .environment(emergencyKitStore)
}


struct KitEssentiaView: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text("Les articles essentiels").textCase(.uppercase).font(.title2).bold()) {
                LazyVGrid(columns: twoColumns) {
                    ForEach(store.createKitEssential()) { item in
                        KitItemView(
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
}

struct KitBabyView: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .leading) {
            Section(header:Text("Pour les bébés").textCase(.uppercase).font(.title2).bold()
            ){ LazyVGrid(columns: twoColumns) {
                ForEach(store.createKitBaby()) { item in
                    KitItemView(
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
        }
        .padding(.bottom, 24)
    }
}

struct KitPetView: View {
    @Environment(EmergencyKitStore.self) var store
    let twoColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(alignment: .leading) {
            Section(header:Text("Pour les animaux").textCase(.uppercase).font(.title2).bold()
            ){
                LazyVGrid(columns: twoColumns) {
                    ForEach(store.createKitPet()) { item in
                        KitItemView(
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
}

