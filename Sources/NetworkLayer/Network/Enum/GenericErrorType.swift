import Foundation

public enum GenericErrorType: Error, Codable {
    
    /// End user authentication failed (or session expired)
    case notAuthorized
    
    case decodingError(description: String?)
    
    /// Development error (4xx codes)
    case errorResponse(response: CustomError)
    
    case internetConnectionLost
    
    case unknown(description: String?)
    
}
