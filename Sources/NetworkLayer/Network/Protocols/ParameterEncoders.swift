import Foundation

public protocol ParameterEncoder: AnyObject {
    func encode<Parameters: Encodable>(_ parameters: Parameters?, into request: inout URLRequest) throws -> URLRequest
}
