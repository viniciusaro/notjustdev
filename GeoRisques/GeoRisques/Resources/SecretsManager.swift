import Foundation

enum SecretsManager {
    static func apiKey() -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["OpenAI_APIKey"] as? String else {
            fatalError("OpenAI API Key not found in Secrets.plist")
        }
        return key
    }
}
