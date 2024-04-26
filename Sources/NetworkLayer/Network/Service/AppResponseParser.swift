import Foundation

public class AppResponseParser {
    static func responseParser<T>() -> ResponseParser<T> where T: Decodable {
        return { httpResponse in
            switch httpResponse.httpCode {
            case 401:
                throw GenericErrorType.notAuthorized
            case 400...:
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: httpResponse.data)
                throw GenericErrorType.errorResponse(response: response.error!)
            default:
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: httpResponse.data)
                guard let data = response.data else {
                    throw GenericErrorType.decodingError(description: response.error?.message?.joined())
                }
                return data
            }
        }
    }
}

extension Request where ResponseType: Decodable {
    public var parser: ResponseParser<ResponseType> {
        return AppResponseParser.responseParser()
    }
}
