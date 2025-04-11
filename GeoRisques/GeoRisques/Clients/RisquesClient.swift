enum RisquesClientError: Error {
    case notFound
}

protocol RisquesClient {
    func risques(at location: Location) async throws -> [Risque]
}

struct FixedRisquesClient: RisquesClient {
    let risques: [Risque]
    
    func risques(at location: Location) async throws -> [Risque] {
        return risques
    }
}


struct UnimplementedRisquesClient: RisquesClient {
    func risques(at location: Location) async throws -> [Risque] {
        throw UnimplementedError()
    }
}
