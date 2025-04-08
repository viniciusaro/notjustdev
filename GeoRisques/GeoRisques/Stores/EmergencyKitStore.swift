import Foundation

@Observable
final class EmergencyKitStore {
    private let client = FamilyMemberClientLive()

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
}
