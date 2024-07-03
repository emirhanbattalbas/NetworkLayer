import Foundation

public enum APISession: Equatable {
    case unauthorized
    case authorized(token: String)
}
