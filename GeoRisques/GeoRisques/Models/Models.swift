import Foundation
import SwiftUI

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
                return "tree"
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
    case adult
    case baby
    case child
    case pet
}

struct EmergencyKitInformation: Identifiable, Equatable {
    let id: UUID = UUID()
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    var image: String
    var tag: Int
}

//MARK: - Emergency Kit Checklist

enum KitEssentialType: String, CaseIterable, Codable, Identifiable {
    case water = "Eau potable en bouteille"
    case food = "Nourriture non périssable"
    case canOpener = "Ouvre-boîte"
    case radio = "Radio à piles"
    case flashlight = "Lampe de poche à piles"
    case batery = "Piles"
    case matches = "Bougies et allumettes"
    case firstAid = "Trousse de premiers secours"
    case warmClothes = "Vêtements chauds"
    case emergencyBlanket = "Couvertures de survie"
    case whistle = "Sifflet"
    case mask = "Masque"
    case toiletPaper = "Papier toilette"
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
        case .water: return "water"
        case .batery: return "batery"
        case .cash: return "cash"
        case .chargers: return "charges"
        case .doubleKey: return "doubleKey"
        case .emergencyBlanket: return "emergencyBlanket"
        case .emergencyContacts: return "emergencyContacts"
        case .firstAid: return "firstAid"
        case .flashlight: return "flashlight"
        case .food: return "food"
        case .game: return "game"
        case .importantDocuments: return "importantDocuments"
        case .localMap: return "localMap"
        case .mask: return "mask"
        case .matches: return "matches"
        case .whistle: return "whistle"
        case .radio: return "radio"
        case .warmClothes: return "warmClothes"
        case .toiletPaper: return "toiletPaper"
        case .canOpener: return "canOpener"
        }
    }
}

enum KitBabyType: String, CaseIterable, Codable, Identifiable {
    case food = "Nourriture pour les bébés"
    case diapers = "Couches"
    case wipes = "Lingettes"
    case babyBottle = "Biberon"
    case pacifier = "Sucette"
    case babyBlanket = "Couverture "
    case babyToy = "Jouets pour les bébés"

    var id: String { self.rawValue }

    var imageName: String {
        switch self {
        case .food: return "babyFood"
        case .diapers: return "diapers"
        case .wipes: return "wipes"
        case .babyBottle: return "babyBottle"
        case .pacifier: return "pacifier"
        case .babyBlanket: return "babyBlanket"
        case .babyToy: return "babyToy"
        }
    }
}


enum KitPetType: String, CaseIterable, Codable, Identifiable {
    case food = "Nourriture pour les animaux"
    case bowl = "Gamelle"
    case leash = "Laisse"
    case blanket = "Couverture"
    case petToy = "Jouets pour les animaux"

    var id: String { self.rawValue }
    
    var imageName: String {
        switch self {
        case .blanket: return "petBlanket"
        case .food: return "petFood"
        case .bowl: return "bowl"
        case .leash: return "leash"
        case .petToy: return "petToy"
        }
    }
}

