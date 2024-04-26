import Foundation

public protocol URLRequestConvertible {
    func asURLRequest(config: APIConfiguration) throws -> URLRequest
}

extension URLRequestConvertible where Self: Request {

    public func asURLRequest(config: APIConfiguration) throws -> URLRequest {
        let url = path.isEmpty ? config.url : config.url.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }
        config.header.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }
        if isSetAuthentication {
            request.setValue(config.token, forHTTPHeaderField: "Authorization")
        }
        return try encoder.encode(parameters, into: &request)
    }

}
