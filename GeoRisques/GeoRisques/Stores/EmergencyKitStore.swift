import Foundation

@Observable
final class EmergencyKitStore {
    private let client = FamilyMemberClientLive()
    private let essentialItemsKey = "selectedEssentialItems"

    var selectedMember: MemberType? = nil
    let memberTypes = MemberType.allCases
    var memberCount: [MemberType: Int] = [
        .adult: 0,
        .baby: 0,
        .child: 0,
        .pet: 0
    ]

    let kitInformation: [EmergencyKitInformation] = EmergencyKitInformation.infos
    var infoIndex: Int = 0
    var navigateToFamilyMembers = false

    var navigateToKitChecklist: Bool = false

    var selectedEssentialItems: Set<KitEssentialItem> = []
    var selectedBabyItems: Set<KitBabyItem> = []
    var selectedPetItems: Set<KitPetItem> = []


    init() {
        loadFamilyMember()
    }

    func incrementMember(_ member: MemberType) {
        memberCount[member, default: 0] += 1
    }

    func decrementMember(_ member: MemberType) {
        if memberCount[member, default: 0] > 0 {
            memberCount[member]! -= 1
        }
    }

    func saveFamilyMember() {
        client.saveMember(memberCount)
    }

    func loadFamilyMember() {
        memberCount = client.loadMember()
    }

    func createKitEssential() -> [KitEssentialItem] {
        var kit: [KitEssentialItem] = []
        if memberCount[.adult] != 0 {
            for item in KitEssentialItemType.allCases {
                kit.append(KitEssentialItem(type: item))
            }
        }
        return kit
    }

    func createKitBaby() -> [KitBabyItem] {
        var kit: [KitBabyItem] = []
        if memberCount[.baby] != 0 {
            for item in KitBabyItemType.allCases {
                kit.append(KitBabyItem(type: item))
            }
        }
        return kit
    }

    func createKitPet() -> [KitPetItem] {
        var kit: [KitPetItem] = []
        if memberCount[.pet] != 0 {
            for item in KitPetItemType.allCases {
                kit.append(KitPetItem(type: item))
            }
        }
        return kit
    }
}
