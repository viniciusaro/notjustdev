import Foundation

struct Location: Equatable {
    let latitude: Double
    let longitude: Double
    let delta: Double
    
    init(latitude: Double, longitude: Double, delta: Double = 0.05) {
        self.latitude = latitude
        self.longitude = longitude
        self.delta = delta
    }
}

struct Risque: Hashable {
    let name: String
    let description: String
    let reference: URL
    let kind: Kind
    
    enum Kind {
        case natural
        case desease
        case technological
        
        var image: String {
            switch self {
            case .natural:
                return "sun.max"
            case .desease:
                return "exclamationmark.triangle"
            case .technological:
                return "wrench"
            }
        }
    }
}

//MARK: - Emergency Kit

enum MemberType: String, CaseIterable, Codable {
    case adult = "Adultes"
    case baby = "Bébés"
    case child = "Enfants"
    case pet = "Animaux"
}

struct EmergencyKitInformation: Identifiable, Equatable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var image: String
    var tag: Int
}

//MARK: - Emergency Kit Checklist

enum KitEssentialItemType: String, CaseIterable, Codable, Identifiable {
    case water = "Eau potable en bouteille"
    case food = "Nourriture non périssable"
    case radio = "Radio"
    case flashlight = "Lampe de poche"
    case batery = "Piles"
    case matches = "Bougies et allumettes"
    case firstAid = "Trousse de premiers secours"
    case warmClothes = "Vêtements chauds"
    case emergencyBlanket = "Couvertures de survie"
    case whistle = "Sifflet"
    case handSanitizer = "Gel hydroalcoolique"
    case mask = "Masque"
    case toiletPaper = "Papier toilette"
    case hygiene = "Produits d'hygiène"
    case chargers = "Chargeurs de téléphone"
    case game = "Jeux"
    case emergencyContacts = "Contacts d'urgence"
    case localMap = "Carte locale"
    case doubleKey = "Clé double"
    case cash = "Argent liquide"
    case importantDocuments = "Documents importants"

    var id: String { self.rawValue }

    var imageName: String {
        switch self {
        case .water: return "lampe"
        case .batery: return "lampe"
        case .cash: return "lampe"
        case .chargers: return "lampe"
        case .doubleKey: return "lampe"
        case .emergencyBlanket: return "lampe"
        case .emergencyContacts: return "lampe"
        case .firstAid: return "lampe"
        case .flashlight: return "lampe"
        case .food: return "lampe"
        case .game: return "lampe"
        case .handSanitizer: return "lampe"
        case .hygiene: return "lampe"
        case .importantDocuments: return "lampe"
        case .localMap: return "lampe"
        case .mask: return "lampe"
        case .matches: return "lampe"
        case .whistle: return "lampe"
        case .radio: return "lampe"
        case .warmClothes: return "lampe"
        case .toiletPaper: return "lampe"
        }
    }
}

enum KitBabyItemType: String, CaseIterable, Codable, Identifiable {
    case food = "Nourriture pour les bébés"
    case diapers = "Couches"
    case wipes = "Lingettes"
    case bottle = "Biberon"
    case pacifier = "Sucette"
    case blanket = "Couverture "
    case toys = "Jouets pour les bébés"

    var id: String { self.rawValue }

    var imageName: String {
        switch self {
        case .food: return "lampe"
        case .diapers: return "lampe"
        case .wipes: return "lampe"
        case .bottle: return "lampe"
        case .pacifier: return "lampe"
        case .blanket: return "lampe"
        case .toys: return "lampe"
        }
    }
}


enum KitPetItemType: String, CaseIterable, Codable, Identifiable {
    case food = "Nourriture pour les animaux"
    case bowl = "Gamelle"
    case leash = "Laisse"
    case blanket = "Couverture"
    case toys = "Jouets pour les animaux"

    var id: String { self.rawValue }
    
    var imageName: String {
        switch self {
        case .blanket: return "lampe"
        case .food: return "lampe"
        case .bowl: return "lampe"
        case .leash: return "lampe"
        case .toys: return "lampe"
        }
    }
}

