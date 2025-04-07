import Foundation

@Observable
final class EmergencyKitStore {
    var selectedMember: String? = nil
    let memberTypes = ["Adultes", "Bébés", "Enfants", "Animaux"]
    var memberCount: [String: Int] = ["Adultes": 0, "Bébés": 0, "Enfants": 0, "Animaux": 0]
    private let userDefaultKey = "savedMemberCount"

    init() {
        load()
    }

    func increment(_ member: String) {
        memberCount[member, default: 0] += 1
    }

    func decrement(_ member: String) {
        if memberCount[member, default: 0] > 0 {
            memberCount[member]! -= 1
        }
    }

    func save() {
        if let data = try? JSONEncoder().encode(memberCount) {
            UserDefaults.standard.set(data, forKey: userDefaultKey)
        }
        print("Saved: \(memberCount)")
    }

    
    func load() {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey),
           let saved = try? JSONDecoder().decode([String: Int].self, from: data) {
            memberCount = saved
        }
        print("Load: \(memberCount)")
    }


}
