import Foundation

@Observable
final class EmergencyKitStore {
    private let FamilyMemberClient = FamilyMemberClientLive()
    private let KitChecklistClient = KitChecklistClientLive()


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
    var selectedEssentialItems = KitChecklistClientLive().selectedEssentialItems
    var selectedBabyItems = KitChecklistClientLive().selectedBabyItems
    var selectedPetItems = KitChecklistClientLive().selectedPetItems

    init() {
        loadFamilyMember()
        loadSelectedItems()
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

    private func loadSelectedItems() {
        KitChecklistClient.saveKitChecklist()
    }
}
