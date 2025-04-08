import Testing
@testable import GeoRisques

struct EmergencyKitTests {

    @Test func testIncrementCount() async throws {
        let store = EmergencyKitStore()

        store.memberCount[MemberType.adult] = 0
        store.incrementMember(MemberType.adult)
        #expect(store.memberCount[MemberType.adult] == 1)
    }


    @Test func testDecrementCount() async throws {
        let store = EmergencyKitStore()

        store.memberCount[MemberType.baby] = 2

        store.decrementMember(MemberType.baby)
        #expect(store.memberCount[MemberType.baby] == 1)

        store.decrementMember(MemberType.baby)
        #expect(store.memberCount[MemberType.baby] == 0)
    }

}
