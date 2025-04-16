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
    let kind: RiskType
}

enum RiskType: Int, CaseIterable, Codable {
    case ruissellementEtCouleeDeBoue = 130
    case mouvementDeTerrain = 134
    case inondation = 140
    case eboulementOuChuteDePierres = 143
    case glissementDeTerrain = 147
    case avanceeDunaire = 152
    case tassementsDifferentiels = 157
    case seisme = 158
    case feuDeForet = 166
    case phenomeneLieAlAtmosphere = 167
    case tempeteEtGrainsVent = 169
    case foudre = 175
    case grele = 176
    case neigeEtPluiesVerglacantes = 177
    case crueDebordementLent = 180
    case crueTorrentielle = 183
    case ruptureDeBarrage = 213
    case risqueIndustriel = 215
    case transportMarchandisesDangereuses = 226
    case radon = 229
    case enginsDeGuerre = 231
    case effetThermique = 236
    case effetDeSurpression = 237
    case effetToxique = 238
    case effondrementsGeneralises = 252
    case affaissementMinier = 254
    case remonteeDeNappesNaturelles = 285
    case submersionMarine = 286
    case defaultRisk = 0

    var imageName: String {
        switch self {
        case .defaultRisk: return "default_risk_icon"
        case .ruissellementEtCouleeDeBoue: return "ruissellement_icon"
        case .mouvementDeTerrain: return "mouvement_terrain_icon"
        case .inondation: return "inondation_icon"
        case .eboulementOuChuteDePierres: return "chute_pierres_icon"
        case .glissementDeTerrain: return "glissement_icon"
        case .seisme: return "seisme_icon"
        case .feuDeForet: return "feu_foret_icon"
        case .crueDebordementLent: return "crue_lente_icon"
        case .crueTorrentielle:  return "crue_rapide_icon"
        case .ruptureDeBarrage: return "barrage_icon"
        case .risqueIndustriel: return "industriel_icon"
        case .transportMarchandisesDangereuses: return "transport_dangereux_icon"
        case .remonteeDeNappesNaturelles: return "nappes_icon"
        case .tassementsDifferentiels: return "tassements_differentiels_icon"
        case .effetThermique: return "effet_thermique_icon"
        case .effetDeSurpression: return "effet_de_surpression_icon"
        case .effetToxique: return "effet_toxique_icon"
        case .effondrementsGeneralises: return "effondrements_generalises_icon"
        case .affaissementMinier: return "affaissement_minier_icon"
        case .submersionMarine: return "submersion_marine_icon"
        case .enginsDeGuerre: return "engins_de_guerre_icon"
        case .radon: return "radon_icon"
        case .phenomeneLieAlAtmosphere: return "phenomene_lie_atmosphere_icon"
        case .tempeteEtGrainsVent: return "tempete_grains_vent_icon"
        case .avanceeDunaire: return "avancee_dunaire_icon"
        case .foudre: return "foudre_icon"
        case .grele: return "grele_icon"
        case .neigeEtPluiesVerglacantes: return "neige_pluies_verglacantes_icon"
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

