import Foundation

public class APIConfiguration {
    internal var language: String
    internal var token: String?
    internal var url: URL
    /**
     - Parameters:
        - header: Information that must be sent for each request
        - token :  for authentication
     **/
    internal var header: [String: String]
    
    public init(url: String,
                language: Language,
                clientId: String,
                clientSecret: String,
                header: [String: String] = [:]) {
        self.url = URL(string: url)!
        self.language = language.rawValue
        self.header = header
        self.token = generateToken(clientId: clientId, clientSecret: clientSecret)
    }
    
    public init(url: String,
                language: Language,
                token: String,
                header: [String: String] = [:]) {
        self.url = URL(string: url)!
        self.language = language.rawValue
        self.header = header
        self.token = token
    }
    
    private func generateToken(clientId: String, clientSecret: String) -> String? {
        let loginString = "\(clientId):\(clientSecret)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else { return nil }
        return "Basic \(loginData.base64EncodedString())"
    }
}
