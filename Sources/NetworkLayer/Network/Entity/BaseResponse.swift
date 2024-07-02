import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public var data: T?
    public var error: CustomError?
    public var path: String?
    public var traceId: String?
}
