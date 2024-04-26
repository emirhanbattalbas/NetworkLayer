import Foundation

public typealias ResponseParser<Response> = (HttpResponse) throws -> Response
