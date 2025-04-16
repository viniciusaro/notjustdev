import Foundation

struct FamilyMemberClientLive: FamilyMemberClient {
    private let userDefaultKey = "savedMemberCount"
    
    func saveMember(_ memberCount: [MemberType: Int]) {
        if let data = try? JSONEncoder().encode(memberCount) {
            UserDefaults.standard.set(data, forKey: userDefaultKey)
        }
        print("Saved: \(memberCount)")
    }

    func loadMember() -> [MemberType : Int] {
        if let data = UserDefaults.standard.data(forKey: userDefaultKey),
           let savedMembers = try? JSONDecoder().decode([MemberType: Int].self, from: data) {
            print("Loaded: \(savedMembers)")
            return savedMembers
        }
        print("No saved members found.")
        return [:]
    }
}


