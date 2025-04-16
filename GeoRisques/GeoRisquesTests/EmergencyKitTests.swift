import Testing
@testable import GeoRisques

struct EmergencyKitTests {
    private let store = EmergencyKitStore()

    /// FamilyMembers Tests
    @Test func isKitButtonActiveTrue() async throws {
        store.memberCount[MemberType.adult] = 1

        let result = store.isKitButtonActive()
        #expect(result == true)
    }

    @Test func isKitButtonActiveFalse() async throws {
        store.memberCount[MemberType.adult] = 0
        store.memberCount[MemberType.child] = 0
        store.memberCount[MemberType.baby] = 0
        store.memberCount[MemberType.pet] = 0

        let result = store.isKitButtonActive()
        #expect(result == false)
    }

    @Test func isKitButtonActiveWithNoAdults() async throws {
        store.memberCount[MemberType.adult] = 0
        store.memberCount[MemberType.child] = 1

        let result = store.isKitButtonActive()
        #expect(result == false)
    }

    @Test func testIncrementCount() async throws {
        store.memberCount[MemberType.adult] = 0
        store.incrementMember(MemberType.adult)
        #expect(store.memberCount[MemberType.adult] == 1)
    }


    @Test func testDecrementCount() async throws {
        store.memberCount[MemberType.baby] = 2

        store.decrementMember(MemberType.baby)
        #expect(store.memberCount[MemberType.baby] == 1)

        store.decrementMember(MemberType.baby)
        #expect(store.memberCount[MemberType.baby] == 0)
    }

    /// Checklist tests
    @Test func createKitEssentialWithAdult() async throws {
        store.memberCount[.adult] = 1
        let result = store.createKitEssential()
        #expect(result == KitEssentialType.allCases)
    }

    @Test func createKitEssentialWithNoAdult() async throws {
        store.memberCount[.adult] = 0
        let result = store.createKitEssential()
        #expect(result.isEmpty)
    }

    @Test func createKitBabyWithBaby() async throws {
        store.memberCount[.baby] = 1
        let result = store.createKitBaby()
        #expect(result == KitBabyType.allCases)
    }

    @Test func createKitBabyWithNoBaby() async throws {
        store.memberCount[.baby] = 0
        let result = store.createKitBaby()
        #expect(result.isEmpty)
    }

    @Test func createKitPetWithPet() async throws {
        store.memberCount[.pet] = 1
        let result = store.createKitPet()
        #expect(result == KitPetType.allCases)
    }

    @Test func createKitPetWithNoPet() async throws {
        store.memberCount[.pet] = 0
        let result = store.createKitPet()
        #expect(result.isEmpty)
    }
}
