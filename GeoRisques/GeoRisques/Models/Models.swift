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


