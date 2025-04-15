import Foundation
import SwiftUI

extension Location {
    static let zero = Location(
        latitude: 0,
        longitude: 0
    )
    
    static let grenoble = Location(
        latitude: 45.171547,
        longitude: 5.722387
    )
    
    static let france = Location(
        latitude: 46.2276,
        longitude: 2.2137,
        delta: 0.5
    )
}

extension Risque {
    static let all = diseases + naturalDisasters
    
    static let naturalDisasters = [
        earthquakes,
        tsunami,
        wildfires,
        floods
    ]
    
    static let tsunami = Risque(
        name: "Tsunamis",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let smallEarthquake = Risque(
        name: "Earthquakes",
        description: "short description",
        reference: reference,
        kind: .natural
    )
    
    static let earthquakes = Risque(
        name: "Earthquakes",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let wildfires = Risque(
        name: "Wildfires",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let floods = Risque(
        name: "Floods",
        description: lipsumDescription,
        reference: reference,
        kind: .natural
    )
    
    static let diseases = [
        dengue,
        yellowFever
    ]
    
    static let dengue = Risque(
        name: "Dengue Fever",
        description: lipsumDescription,
        reference: reference,
        kind: .disease
    )
    
    static let yellowFever = Risque(
        name: "Yellow Fever",
        description: lipsumDescription,
        reference: reference,
        kind: .disease
    )
    
    static let lipsumDescription = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non mauris a velit imperdiet efficitur. Praesent ex augue, vehicula vel sapien scelerisque, feugiat interdum purus. Ut nec dapibus leo, vel pulvinar mauris. Nunc neque dolor, dignissim lacinia sapien eget, suscipit egestas lorem. Nulla vehicula ipsum at leo porta, sed hendrerit dui molestie. Etiam in placerat mauris, ut tincidunt ex. Integer eu sapien sodales, facilisis leo sed, laoreet lacus.

        Praesent tempor mi ut purus gravida semper. Donec eu magna massa. Aenean placerat in ex ac interdum. Donec in tempus est. Sed consequat scelerisque egestas. Vestibulum ut feugiat tellus. Pellentesque suscipit bibendum augue ut bibendum. Etiam varius rhoncus sapien, facilisis mollis ipsum interdum eu. Nunc eu mauris in sapien dapibus bibendum. Ut placerat urna nisl, ut porta elit vehicula bibendum. Sed non magna sit amet orci aliquam lacinia quis sed est. Vestibulum condimentum eleifend ligula ac condimentum. Maecenas vitae ipsum ac nisi eleifend aliquam. Praesent convallis ligula sed aliquam ultricies. Aenean commodo tincidunt metus in fermentum. Proin eu erat neque.

        Quisque feugiat tempor porta. Quisque viverra diam ac eros accumsan auctor. Nam vulputate massa vitae maximus dapibus. Etiam blandit libero in lacus fermentum faucibus. Ut quam neque, vestibulum sit amet massa sed, aliquet sollicitudin erat. Cras semper magna euismod, aliquam erat eu, gravida mauris. Maecenas quis massa nec eros interdum cursus at eget nulla. Sed molestie commodo nunc. Curabitur aliquam metus urna, id lobortis dui lacinia ac. Suspendisse vulputate, magna scelerisque euismod blandit, nisi sem sodales nisi, non mattis purus leo ac felis. Quisque accumsan ut lacus at semper. Duis turpis mi, dictum aliquam augue id, maximus feugiat elit. Quisque neque purus, ornare nec sapien at, fringilla mollis nisl. Donec condimentum odio ac elit aliquet, tempor volutpat urna hendrerit.

        Nulla pharetra lobortis nisl, non blandit libero pulvinar eu. Vivamus vulputate, sapien in facilisis ultricies, ex nunc gravida augue, vel accumsan purus eros et felis. Aliquam erat volutpat. Morbi molestie malesuada orci, ut sodales purus convallis quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin auctor tempor sodales. Sed fermentum, dolor vel dapibus sollicitudin, quam nulla consectetur libero, et luctus tellus dui vitae eros. Aenean sit amet cursus ante. Maecenas sed felis ligula. Donec feugiat laoreet lectus. Fusce vitae dictum massa, nec lacinia turpis.
        """
    
    static let reference = URL(string: "https://www.georisques.gouv.fr")!
}

//MARK: - Emergency Kit

extension EmergencyKitInformation {
    static let infos: [EmergencyKitInformation] = [
        EmergencyKitInformation(
            title: LocalizedStringKey("intro_kit_title"),
            description: LocalizedStringKey("intro_kit_subtitle"),
            image: "emergencyKit",
            tag: 0
        ),

        EmergencyKitInformation(
            title: LocalizedStringKey("prepare_kit_title"),
            description: LocalizedStringKey("prepare_kit_subtitle"),
            image: "preparer",
            tag: 1
        ),

        EmergencyKitInformation(
            title: LocalizedStringKey("equip_kit_title"),
            description: LocalizedStringKey("prepare_kit_subtitle"),
            image: "equiper",
            tag: 2
        ),

        EmergencyKitInformation(
            title: LocalizedStringKey("check_kit_title"),
            description: LocalizedStringKey("check_kit_subtitle"),
            image: "verifier",
            tag: 3
        ),
    ]
}

extension MemberType {
    var localizedName: LocalizedStringKey {
        switch self {
        case .adult: return "Adultes"
        case .baby: return "Bébés"
        case .child: return "Enfants"
        case .pet: return "Animaux"
        }
    }
}

extension KitEssentialType {
    var localizedName: LocalizedStringKey {
        let key: String

        switch self {
        case .water: key = "kitEssentialType.water"
        case .food: key = "kitEssentialType.food"
        case .canOpener: key = "kitEssentialType.canOpener"
        case .radio: key = "kitEssentialType.radio"
        case .flashlight: key = "kitEssentialType.flashlight"
        case .batery: key = "kitEssentialType.batery"
        case .matches: key = "kitEssentialType.matches"
        case .firstAid: key = "kitEssentialType.firstAid"
        case .warmClothes: key = "kitEssentialType.warmClothes"
        case .emergencyBlanket: key = "kitEssentialType.emergencyBlanket"
        case .whistle: key = "kitEssentialType.whistle"
        case .mask: key = "kitEssentialType.mask"
        case .toiletPaper: key = "kitEssentialType.toiletPaper"
        case .chargers: key = "kitEssentialType.chargers"
        case .game: key = "kitEssentialType.game"
        case .emergencyContacts: key = "kitEssentialType.emergencyContacts"
        case .localMap: key = "kitEssentialType.localMap"
        case .doubleKey: key = "kitEssentialType.doubleKey"
        case .cash: key = "kitEssentialType.cash"
        case .importantDocuments: key = "kitEssentialType.importantDocuments"
        }

        return LocalizedStringKey(key)
    }
}

extension KitBabyType {
    var localizedName: LocalizedStringKey {
        let key: String

        switch self {
        case .food: key = "kitBabyType.food"
        case .diapers: key = "kitBabyType.diapers"
        case .wipes: key = "kitBabyType.wipes"
        case .babyBottle: key = "kitBabyType.babyBottle"
        case .pacifier: key = "kitBabyType.pacifier"
        case .babyBlanket: key = "kitBabyType.babyBlanket"
        case .babyToy: key = "kitBabyType.babyToy"
        }

        return LocalizedStringKey(key)
    }
}

extension KitPetType {
    var localizedName: LocalizedStringKey {
        let key: String

        switch self {
        case .blanket: key = "kitPetType.petBlanket"
        case .food: key = "kitPetType.petFood"
        case .bowl: key = "kitPetType.bowl"
        case .leash: key = "kitPetType.leash"
        case .petToy: key = "kitPetType.petToy"
        }

        return LocalizedStringKey(key)
    }
}
