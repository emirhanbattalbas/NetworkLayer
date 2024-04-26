import Foundation
import PromiseKit

public class AppRequestLoader: NSObject, RequestLoaderProtocol {
    
    var urlSession: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        let session = URLSession(configuration: configuration)
        return session
    }
    
    public func load(request: URLRequest) -> Promise<HttpResponse> {
        return Promise { seal in
            self.urlSession.dataTask(with: request) { data, response, error in
                if let data = data, let httpResponse = response as? HTTPURLResponse {
                    let httpResponse = HttpResponse(data: data,
                                                    apiName: request.apiName,
                                                    httpCode: httpResponse.statusCode)
                    seal.fulfill(httpResponse)
                    
                } else {
                    guard let error = error else { return }
                    seal.reject(error)
                }
            }.resume()
        }
    }
    
//    public func load(request: URLRequest, multipartFormList: [MultipartForm.Part]) -> Promise<HttpResponse> {
//        var _request = request
//        let form = MultipartForm(parts: multipartFormList)
//        _request.setValue(form.contentType, forHTTPHeaderField: "Content-Type")
//        
//        return firstly { () -> Promise<HttpResponse> in
//            self.urlSession.uploadTask(.promise, with: _request, from: form.bodyData)
//                .map { data, urlResponse in
//                    let httpUrlResponse = self.parsHTTPURLResponse(response: urlResponse)
//                    return HttpResponse(data: data,
//                                        apiName: request.apiName,
//                                        httpCode: httpUrlResponse.value!.statusCode)
//                }
//        }
//    }
}

private extension URLRequest {
    
    var apiName: String {
        return url?.path.components(separatedBy: "/").last ?? ""
    }
    
}
