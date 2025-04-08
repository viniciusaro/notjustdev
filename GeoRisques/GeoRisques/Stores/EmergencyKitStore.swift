import Foundation

@Observable
final class EmergencyKitStore {
    var selectedMember: String? = nil
    let memberTypes = MemberType.allCases
    var memberCount: [String: Int] = [
        "Adultes": 0,
        "Bébés": 0,
        "Enfants": 0,
        "Animaux": 0
    ]
    private let userDefaultKey = "savedFamilyMembers"

    let kitInformation: [EmergencyKitInformation] = EmergencyKitInformation.infos
    var infoIndex: Int = 0
    var navigateToFamilyMembers = false

    var memberIsTapped: Bool = false

    init() {
        loadSavedFamilyMembers()
    }

    func tapMember(_ member: String) {
        memberIsTapped = true
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
        if let data = try? JSONEncoder().encode(memberCount) {
            UserDefaults.standard.set(data, forKey: userDefaultKey)
        }
        print("Saved: \(memberCount)")
    }

    
    func loadSavedFamilyMembers() {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey),
           let saved = try? JSONDecoder().decode([String: Int].self, from: data) {
            memberCount = saved
        }
        print("Load: \(memberCount)")
    }
}
