
protocol FamilyMemberClient {
    func saveMember(_ memberCount: [MemberType: Int])
    func loadMember() -> [MemberType : Int]
}
