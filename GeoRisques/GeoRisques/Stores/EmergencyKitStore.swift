import Foundation

@Observable
final class EmergencyKitStore {
    private let client = MemberFamilyClientLive()

    var selectedMember: String? = nil
    let memberTypes = MemberType.allCases
    var memberCount: [String: Int] = [
        "Adultes": 0,
        "Bébés": 0,
        "Enfants": 0,
        "Animaux": 0
    ]

    let kitInformation: [EmergencyKitInformation] = EmergencyKitInformation.infos
    var infoIndex: Int = 0
    var navigateToFamilyMembers = false

    init() {
        loadFamilyMember()
    }

    func incrementMember(_ member: String) {
        memberCount[member, default: 0] += 1
    }

    func decrementMember(_ member: String) {
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
