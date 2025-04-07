import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

struct Risque: Hashable {
    let name: String
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


