import Foundation
import SwiftUI

@Observable
final class EmergencyKitStore {
    private let FamilyMemberClient = FamilyMemberClientLive()

    /// EmergencyKitIntro Data
    let kitInformation: [EmergencyKitInformation] = EmergencyKitInformation.infos
    var infoIndex: Int = 0
    var navigateToFamilyMembers = false


    /// FamilyMembers Data
    var selectedMember: MemberType? = nil
    let memberTypes = MemberType.allCases
    var memberCount: [MemberType: Int] = [
        .adult: 0,
        .baby: 0,
        .child: 0,
        .pet: 0
    ]


    /// Checklist Data
    private let selectedEssentialItemsKey = "essentialItemsKey"
    var navigateToChecklist: Bool = false
    var selectedEssentialItems: Set<KitEssentialType> = [] {
        didSet {
            saveEssentialSelectedItems()
        }
    }

    private let selectedBabyItemsKey = "selectedBabyItemsKey"
    var selectedBabyItems: Set<KitBabyType> = [] {
        didSet {
            saveBabySelectedItems()
        }
    }

    private let selectedPetItemsKey = "selectedPetItemsKey"
    var selectedPetItems: Set<KitPetType> = [] {
        didSet {
            savePetSelectedItems()
        }
    }

    init() {
        loadFamilyMember()
        loadEssentialSelectedItems()
        loadBabySelectedItems()
        loadPetSelectedItems()
    }


    /// FamilyMembers logics
    func isKitButtonActive() -> Bool {
        let isTrue = memberCount.values.contains(where: { $0 > 0 }) && memberCount[.adult] ?? 0 != 0
        return isTrue
    }

    func incrementMember(_ member: MemberType) {
        memberCount[member, default: 0] += 1
    }

    func decrementMember(_ member: MemberType) {
        if memberCount[member, default: 0] > 0 {
            memberCount[member]! -= 1
        }
    }

    func saveFamilyMember() {
        FamilyMemberClient.saveMember(memberCount)
    }

    private func loadFamilyMember() {
        memberCount = FamilyMemberClient.loadMember()
    }



    /// Checklist logics
    func createKitEssential() -> [KitEssentialType] {
        guard memberCount[.adult, default: 0] > 0 else { return [] }
        return KitEssentialType.allCases
    }

    func createKitBaby() -> [KitBabyType] {
        guard memberCount[.baby, default: 0] > 0 else { return [] }
        return KitBabyType.allCases
    }

    func createKitPet() -> [KitPetType] {
        guard memberCount[.pet, default: 0] > 0 else { return [] }
        return KitPetType.allCases
    }

    //Essential Kit
    private func loadEssentialSelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedEssentialItemsKey) else { return }
        selectedEssentialItems = Set(kit.compactMap { KitEssentialType(rawValue: $0) })
    }

    private func saveEssentialSelectedItems() {
        let raw = selectedEssentialItems.map(\.rawValue)
        UserDefaults.standard.set(raw, forKey: selectedEssentialItemsKey)
    }

    //Baby Kit
    private func loadBabySelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedBabyItemsKey) else { return }
        selectedBabyItems = Set(kit.compactMap { KitBabyType(rawValue: $0) })
    }

    private func saveBabySelectedItems() {
        let kit = selectedBabyItems.map(\.rawValue)
        UserDefaults.standard.set(kit, forKey: selectedBabyItemsKey)
    }

    //Pet Kit
    private func loadPetSelectedItems() {
        guard let kit = UserDefaults.standard.stringArray(forKey: selectedPetItemsKey) else { return }
        selectedPetItems = Set(kit.compactMap { KitPetType(rawValue: $0) })
    }

    private func savePetSelectedItems() {
        let kit = selectedPetItems.map(\.rawValue)
        UserDefaults.standard.set(kit, forKey: selectedPetItemsKey)
    }
}
