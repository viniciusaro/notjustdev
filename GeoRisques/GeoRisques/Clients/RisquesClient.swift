enum RisquesClientError: Error {
    case notFound
}

protocol RisquesClient {
    func risques(at location: Location) async throws -> ([Risque], String?)
}

struct FixedRisquesClient: RisquesClient {
    let risques: [Risque]
    let community: String?
    
    init(risques: [Risque], community: String? = nil) {
        self.risques = risques
        self.community = community
    }
    
    func risques(at location: Location) async throws -> ([Risque], String?) {
        return (risques, community)
    }
}


struct UnimplementedRisquesClient: RisquesClient {
    func risques(at location: Location) async throws -> ([Risque], String?) {
        throw UnimplementedError()
    }
}
