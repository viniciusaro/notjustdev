import Foundation

@Observable
final class EmergencyKitStore {
    private let FamilyMemberClient = FamilyMemberClientLive()

    /// EmergencyKit Data
    let kitInformation: [EmergencyKitInformation] = EmergencyKitInformation.infos
    var infoIndex: Int = 0
    var navigateToFamilyMembers = false


    /// FamilyMembers Data
    var selectedMember: MemberType? = nil
    let memberTypes = MemberType.allCases
    var memberCount: [MemberType: Int] = [
        .adult: 0,
        .baby: 0,
        .child: 0,
        .pet: 0
    ]
    var navigateToKitChecklist: Bool = false

    /// KitChecklist logics
    private let selectedEssentialItemsKey = "essentialItemsKey"
    var selectedEssentialItems: Set<KitEssentialItemType> = [] {
        didSet {
            saveEssentialSelectedItems()
        }
    }

    private let selectedBabyItemsKey = "selectedBabyItemsKey"
    var selectedBabyItems: Set<KitBabyItemType> = [] {
        didSet {
            saveBabySelectedItems()
        }
    }

    private let selectedPetItemsKey = "selectedPetItemsKey"
    var selectedPetItems: Set<KitPetItemType> = [] {
        didSet {
            savePetSelectedItems()
        }
    }




    init() {
        loadFamilyMember()
        loadEssentialSelectedItems()
        loadBabySelectedItems()
        loadPetSelectedItems()
    }


    /// FamilyMembers logics
    func incrementMember(_ member: MemberType) {
        memberCount[member, default: 0] += 1
    }

    func decrementMember(_ member: MemberType) {
        if memberCount[member, default: 0] > 0 {
            memberCount[member]! -= 1
        }
    }

    func saveFamilyMember() {
        FamilyMemberClient.saveMember(memberCount)
    }

    private func loadFamilyMember() {
        memberCount = FamilyMemberClient.loadMember()
    }



    /// KitChecklist logics
    func createKitEssential() -> [KitEssentialItemType] {
        guard memberCount[.adult, default: 0] > 0 else { return [] }
        return KitEssentialItemType.allCases
    }

    func createKitBaby() -> [KitBabyItemType] {
        guard memberCount[.baby, default: 0] > 0 else { return [] }
        return KitBabyItemType.allCases
    }

    func createKitPet() -> [KitPetItemType] {
        guard memberCount[.pet, default: 0] > 0 else { return [] }
        return KitPetItemType.allCases
    }

    //-----------Essential Kit------------
    private func loadEssentialSelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedEssentialItemsKey) else { return }
        selectedEssentialItems = Set(kit.compactMap { KitEssentialItemType(rawValue: $0) })
    }

    private func saveEssentialSelectedItems() {
        let raw = selectedEssentialItems.map(\.rawValue)
        UserDefaults.standard.set(raw, forKey: selectedEssentialItemsKey)
    }

    //-----------Baby Kit------------
    private func loadBabySelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedBabyItemsKey) else { return }
        selectedBabyItems = Set(kit.compactMap { KitBabyItemType(rawValue: $0) })
    }

    private func saveBabySelectedItems() {
        let kit = selectedBabyItems.map(\.rawValue)
        UserDefaults.standard.set(kit, forKey: selectedBabyItemsKey)
    }

    //-----------Baby Kit------------
    private func loadPetSelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedPetItemsKey) else { return }
        selectedPetItems = Set(kit.compactMap { KitPetItemType(rawValue: $0) })
    }

    private func savePetSelectedItems() {
        let kit = selectedPetItems.map(\.rawValue)
        UserDefaults.standard.set(kit, forKey: selectedPetItemsKey)
    }
}
