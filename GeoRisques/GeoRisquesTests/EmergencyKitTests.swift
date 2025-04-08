import Testing
@testable import GeoRisques

struct EmergencyKitTests {

    @Test func testIncrementCount() async throws {
        let store = EmergencyKitStore()

        store.memberCount["Adultes"] = 0
        store.incrementMember("Adultes")
        #expect(store.memberCount["Adultes"] == 1)
    }


    @Test func testDecrementCount() async throws {
        let store = EmergencyKitStore()

        store.memberCount["Enfants"] = 2

        store.decrementMember("Enfants")
        #expect(store.memberCount["Enfants"] == 1)

        store.decrementMember("Enfants")
        #expect(store.memberCount["Enfants"] == 0)
    }

}
