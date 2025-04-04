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
