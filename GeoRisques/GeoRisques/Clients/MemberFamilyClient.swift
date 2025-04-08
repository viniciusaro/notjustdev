protocol MemberFamilyClient {
    func saveMember(_ memberCount: [String: Int])
    func loadMember() -> [String : Int] 
}
