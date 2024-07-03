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
    var url: URL { get }
    var isSetAuthorization: Bool { get }
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
    
    public var parameters: Parameter? {
        return nil
    }
    
    public var url: URL? {
        return nil
    }
    
    public var isSetAuthorization: Bool {
        return true
    }
    
}
