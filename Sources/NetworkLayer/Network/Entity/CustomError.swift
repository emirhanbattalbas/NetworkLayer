import Foundation

public struct CustomError: Error, Codable {
    public var statusCode: Int?
    public var error: String?
    public var message: [String]?
    public var errorCode: String?
}
