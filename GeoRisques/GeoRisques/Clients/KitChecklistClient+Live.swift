import Foundation

struct KitChecklistClientLive: KitChecklistClient {
    private let selectedItemsKey = "selectedEssentialItems"

    var selectedEssentialItems: Set<KitEssentialItemType> = [] {
        didSet { saveKitChecklist() }
    }

    var selectedBabyItems: Set<KitBabyItemType> = [] {
        didSet { saveKitChecklist() }
    }

    var selectedPetItems: Set<KitPetItemType> = [] {
        didSet { saveKitChecklist() }
    }

    func saveKitChecklist() {
        let kit = selectedEssentialItems.map { $0.rawValue }
        UserDefaults.standard.set(kit, forKey: selectedItemsKey)
    }
    
    func loadKitChecklist() {
        let kit = selectedEssentialItems.map { $0.rawValue }
        UserDefaults.standard.set(kit, forKey: selectedItemsKey)
    }
}
