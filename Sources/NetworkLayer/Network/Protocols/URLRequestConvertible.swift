import Foundation

public protocol URLRequestConvertible {
    func asURLRequest(baseUrl: URL) throws -> URLRequest
}

extension URLRequestConvertible where Self: Request {

    public func asURLRequest(baseUrl: URL) throws -> URLRequest {
        let url = path.isEmpty ? baseUrl : baseUrl.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("ja", forHTTPHeaderField: "Accept-Language")
        headers.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }
        return try encoder.encode(parameters, into: &request)
    }

}
