enum LocationClientError: Error {
    case unauthorized
    case unavailable
}

protocol LocationClient {
    func location() async throws -> Location
}

final class UnimplementedLocationClient: LocationClient {
    func location() async throws -> Location {
        throw UnimplementedError()
    }
}


final class FixedLocationClient: LocationClient {
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    func location() async throws -> Location {
        return location
    }
}
