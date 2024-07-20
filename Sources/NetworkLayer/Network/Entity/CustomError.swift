import Foundation

public struct CustomError: Error, Codable {
    public var statusCode: Int?
    public var error: String?
    public var message: [String]?
    public var errorCode: String?
    
    init(statusCode: Int? = nil, error: String? = nil, message: [String]? = nil, errorCode: String? = nil) {
        self.statusCode = statusCode
        self.error = error
        self.message = message
        self.errorCode = errorCode
    }
}
