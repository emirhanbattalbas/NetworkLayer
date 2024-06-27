import Foundation

public class JSONParameterEncoder: ParameterEncoder {
    
    static let shared = JSONParameterEncoder()
    public let encoder: JSONEncoder

    public init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    open func encode<Parameters: Encodable>(_ parameters: Parameters?,
                                            into request: inout URLRequest) throws -> URLRequest {
        guard let parameters = parameters else { return request }

        do {
            let data = try encoder.encode(parameters)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw ParameterEncodingError.invalidUrl
        }

        return request
    }
}
