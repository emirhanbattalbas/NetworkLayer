import Foundation
import PromiseKit

public class AppService: APIService {
    
    public let loader: RequestLoaderProtocol = AppRequestLoader()
    public var session: APISession = .unauthorized
    
    public init() { }
    
    public func send<T>(request: T) -> Promise<T.ResponseType> where T : Request {
        return Promise<T.ResponseType> { seal in
            var _request = try request.asURLRequest(baseUrl: request.url)
            _request = authorize(request: _request)

            firstly {
                return self.loader.load(request: _request)
            }.done { response in
                let parser = try request.parser(response)
                seal.fulfill(parser)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
    private func authorize(request: URLRequest) -> URLRequest {
        switch session {
        case let .authorized(token):
            var mutableRequest = request
            mutableRequest.setValue(token, forHTTPHeaderField: "Authorization")
            return mutableRequest
        default:
            return request
        }
    }
}

extension Thenable where T == URLRequest { }
