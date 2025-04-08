import Foundation

struct MemberFamilyClientLive: MemberFamilyClient {
    private let userDefaultKey = "savedMemberCount"
    
    func saveMember(_ memberCount: [String: Int]) {
        if let data = try? JSONEncoder().encode(memberCount) {
            UserDefaults.standard.set(data, forKey: userDefaultKey)
        }
        print("Saved: \(memberCount)")
    }

    func loadMember() -> [String : Int] {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey),
           let savedMembers = try? JSONDecoder().decode([String: Int].self, from: data) {
            print("Loaded: \(savedMembers)")
            return savedMembers
        }
        print("No saved members found.")
        return [:]
    }
}
