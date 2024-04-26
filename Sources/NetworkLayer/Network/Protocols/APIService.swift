import Foundation
import PromiseKit

public protocol APIService: AnyObject {
    func send<T>(request: T) -> Promise<T.ResponseType> where T: Request
}
