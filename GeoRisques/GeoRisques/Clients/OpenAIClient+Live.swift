import Foundation

struct OpenAIClientLive: OpenAIClient {
    static let shared = OpenAIClientLive()
    private let apiKey = SecretsManager.apiKey()
    private let endpoint = URL(string: "https://api.deepinfra.com/v1/openai/chat/completions")!

    func askAI(prompt: String) async throws -> String {
        let request = OpenAIRequest(messages: [.init(role: "user", content: prompt)])

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                let errorMessage = String(data: data, encoding: .utf8) ?? "unknown error"
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            }
            let decodedResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            return decodedResponse.choices.first?.message.content ?? "No response."
        } catch {
            throw error
        }
    }
}


struct OpenAIClientMock: OpenAIClient {
    static let shared = OpenAIClientMock()

    func askAI(prompt: String) async throws -> String {
        let mockData = OpenAIResponse(choices: OpenAIResponse.placeholder.choices)
        try await Task.sleep(nanoseconds: 1000_000_000)
        return mockData.choices.first!.message.content
    }
}
