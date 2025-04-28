protocol OpenAIClient {
    func askAI(prompt: String) async throws -> String
}
