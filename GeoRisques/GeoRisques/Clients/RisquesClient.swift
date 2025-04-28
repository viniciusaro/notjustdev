enum RisksClientError: Error {
    case notFound
}

protocol RisksClient {
    func risques(at location: Location) async throws -> ([Risk], String?)
}

struct FixedRisksClient: RisksClient {
    let risques: [Risk]
    let community: String?
    
    init(risks: [Risk], community: String? = nil) {
        self.risques = risks
        self.community = community
    }
    
    func risques(at location: Location) async throws -> ([Risk], String?) {
        return (risques, community)
    }
}


struct UnimplementedRisquesClient: RisksClient {
    func risques(at location: Location) async throws -> ([Risk], String?) {
        throw UnimplementedError()
    }
}
