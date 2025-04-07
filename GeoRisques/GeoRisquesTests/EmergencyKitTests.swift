import Testing
@testable import GeoRisques

struct EmergencyKitTests {

    @Test func testIncrementCount() async throws {
        let store = EmergencyKitStore()
        
        #expect(store.memberCount["Adultes", default: 0] == 0)

        store.increment("Adultes")
        #expect(store.memberCount["Adultes", default: 0] == 1)
    }


    @Test func testDecrementCount() async throws {
        let store = EmergencyKitStore()

        store.memberCount["Enfants"] = 2

        store.decrement("Enfants")
        #expect(store.memberCount["Enfants"] == 1)

        store.decrement("Enfants")
        #expect(store.memberCount["Enfants"] == 0)
    }

}
