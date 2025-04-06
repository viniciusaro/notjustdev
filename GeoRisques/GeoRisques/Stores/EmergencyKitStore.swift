import Foundation

@Observable
final class EmergencyKitStore {
    let memberTypes = ["Adultes", "Bébés", "Enfants", "Animaux"]
    
    var memberCount: [String: Int] = [
        "Adultes": 0,
        "Bébés": 0,
        "Enfants": 0,
        "Animaux": 0
    ]

    var selectedMember: String? = nil

    func increment(_ member: String) {
        memberCount[member, default: 0] += 1
    }

    func decrement(_ member: String) {
        if memberCount[member, default: 0] > 0 {
            memberCount[member]! -= 1
        }
    }

    func save() {
        print("Saving family: \(memberCount)")
    }
}
