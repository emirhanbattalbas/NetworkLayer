import Foundation

public enum HeaderContentType {
    case json
    case url
    case none
    
    var value: [String: String] {
        switch self {
        case .json:
            return ["content-type": "application/json"]
        case .url:
            return ["content-type": ""]
        case .none:
            return [:]
        }
    }
}
