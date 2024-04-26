import PromiseKit
import Foundation

public protocol RequestLoaderProtocol {
    func load(request: URLRequest) -> Promise<HttpResponse>
}
