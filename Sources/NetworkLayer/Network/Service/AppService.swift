import Foundation
import PromiseKit

public class AppService: APIService {
    
    public let loader: RequestLoaderProtocol = AppRequestLoader()
    let config: APIConfiguration
    
    public init(config: APIConfiguration) {
        self.config = config
    }
    
    public func send<T>(request: T) -> Promise<T.ResponseType> where T : Request {
        return Promise<T.ResponseType> { seal in
            let _request = try request.asURLRequest(config: self.config)
            
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
}

extension Thenable where T == URLRequest { }
