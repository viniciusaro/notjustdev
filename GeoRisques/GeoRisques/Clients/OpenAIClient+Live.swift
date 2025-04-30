import Foundation

struct OpenAIClientLive: OpenAIClient {
    static let shared = OpenAIClientLive()
    private let apiKey = SecretsClientLive().apiKey()
    private let endpoint = URL(string: "https://api.deepinfra.com/v1/openai/chat/completions")!

    func askAI(prompt: String) async throws -> String {
        let request = OpenAIRequest(messages: [.init(role: "user", content: prompt)])

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "ai-error-response"])
            }
        
        guard httpResponse.statusCode == 200 else {
                let errorMessage = String(data: data, encoding: .utf8) ?? "Unknown error"
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            }
        
        let decodedResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        
        guard let content = decodedResponse.choices.first?.message.content, !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
              return NSLocalizedString("ai-error-response", comment: "Fallback response if AI fails")
          }

          return content
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
