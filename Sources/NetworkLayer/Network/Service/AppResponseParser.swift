import Foundation

public class AppResponseParser {
    static func responseParser<T>() -> ResponseParser<T> where T: Decodable {
        return { httpResponse in
            switch httpResponse.httpCode {
            case 401:
                throw GenericErrorType.notAuthorized
            case 400...499:
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: httpResponse.data)
                throw GenericErrorType.errorResponse(response: response.error!)
            case 500:
                let response = try JSONDecoder().decode(CustomError.self, from: httpResponse.data)
                throw GenericErrorType.unknown(description: response.message)
            default:
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: httpResponse.data)
                guard let data = response.data else {
                    throw GenericErrorType.decodingError(description: response.error?.message)
                }
                return data
            }
        }
    }
    
    static func emptyResponseParser() -> ResponseParser<Void> {
        return { httpResponse in
            switch httpResponse.httpCode {
            case 401:
                throw GenericErrorType.notAuthorized
            case 200...:
                return
            default:
                throw CustomError(statusCode: httpResponse.httpCode, error: httpResponse.apiName)
            }
        }
    }
    
    static func customResponseParser<T>() -> ResponseParser<T> where T: Decodable {
        return { httpResponse in
            switch httpResponse.httpCode {
            case 200...:
                let response = try JSONDecoder().decode(T.self, from: httpResponse.data)
                return response
            default:
                throw CustomError(statusCode: httpResponse.httpCode, error: httpResponse.apiName)
            }
        }
    }
}

extension Request where ResponseType: Decodable {
    public var parser: ResponseParser<ResponseType> {
        return AppResponseParser.responseParser()
    }
    
    public var customParser: ResponseParser<ResponseType> {
        return AppResponseParser.customResponseParser()
    }
}

extension Request where ResponseType == Void {
    public var parser: ResponseParser<ResponseType> {
        return AppResponseParser.emptyResponseParser()
    }
}
