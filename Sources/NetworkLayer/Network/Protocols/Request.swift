import Foundation

public protocol Request: URLRequestConvertible {
    associatedtype ResponseType
    associatedtype Parameter: Encodable
    
    var path: String { get }
    var parameters: Parameter? { get }
    var headers: [String: String] { get }
    var method: HttpMethod { get }
    var encoder: ParameterEncoder { get }
    var parser: ResponseParser<ResponseType> { get }
    var isSetAuthentication: Bool { get }
}

extension Request {
    public var encoder: ParameterEncoder {
        switch method {
        case .get: return URLParameterEncoder.shared
        case .post, .put, .delete, .patch, .head: return JSONParameterEncoder.shared
        }
    }
    
    public var headers: [String: String] {
        switch method {
        case .get: return HeaderContentType.url.value
        case .post, .put, .delete, .patch, .head: return HeaderContentType.json.value
        }
    }
    
    public var isSetAuthentication: Bool {
        return true
    }
    
    public var parameters: Parameter? {
        return nil
    }
}
