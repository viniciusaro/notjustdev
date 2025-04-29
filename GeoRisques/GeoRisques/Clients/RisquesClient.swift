enum RisksClientError: Error {
    case notFound
}

protocol RisksClient {
    func risks(at location: Location) async throws -> ([Risk], String?)
}

struct FixedRisksClient: RisksClient {
    let risks: [Risk]
    let community: String?
    
    init(risks: [Risk], community: String? = nil) {
        self.risks = risks
        self.community = community
    }
    
    func risks(at location: Location) async throws -> ([Risk], String?) {
        return (risks, community)
    }
}

struct UnimplementedRisksClient: RisksClient {
    func risks(at location: Location) async throws -> ([Risk], String?) {
        throw UnimplementedError()
    }
}
