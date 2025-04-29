import Foundation

final class LiveRisksClient: RisksClient {
    private let risksURL = URL(string: "https://georisques.gouv.fr/api/v1/gaspar/risques")!
    
    func risks(at location: Location) async throws -> ([Risk], String?) {
        let request = URLRequest(url: risksURL.appending(queryItems: [
            URLQueryItem(name: "rayon", value: "1000"),
            URLQueryItem(name: "page_size", value: "20"),
            URLQueryItem(name: "latlon", value: "\(location.longitude),\(location.latitude)"),
        ]))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

        guard let jdata = json["data"] as? [[String: Any]], !jdata.isEmpty else {
            throw RisksClientError.notFound
        }

        let risksData = jdata.first!["risques_detail"] as! [[String: Any]]

        let community = jdata.first?["libelle_commune"] as? String
        
        let risks = risksData.map {
            let name = $0["libelle_risque_long"] as! String
            let num = Int($0["num_risque"] as! String) ?? 0
            let riskType = RiskType(rawValue: num)

            let nameParam = name.lowercased().replacingOccurrences(of: " ", with: "-")
            
            return Risk(
                name: name,
                description: $0["libelle_risque_long"] as! String,
                reference: URL(string: "https://www.georisques.gouv.fr/minformer-sur-un-risque/\(nameParam)")!,
                kind: riskType ?? .defaultRisk
            )
        }
        return (risks, community)
    }
}
