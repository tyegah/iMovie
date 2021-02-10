//
//  BaseHTTPClient.swift
//  PokeApp
//
//  Created by UN A on 04/11/20.
//

import Foundation


let BASE_URL = "https://api.themoviedb.org/3/"
let HTTP_STATUS_OK = 200

public protocol HTTPClientTask {
    func cancel()
}

public enum AppError: Swift.Error {
    case connectivity
    case invalidRequestData(String?)
    case invalidResponseData(String?)
    case emptyData
    case unauthorizedAccess
}

public typealias RequestHeader = [String:String]
public typealias HTTPClientResult = (Result<(Data,HTTPURLResponse), Error>) -> Void

public protocol BaseHttpClient {
    @discardableResult
    func get(_ url: String, params: [String:Any]?, headers: RequestHeader?, completion: @escaping HTTPClientResult) -> HTTPClientTask
}


public final class URLSessionClient: BaseHttpClient {
    private let session: URLSession

    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private struct UnexpectedError:Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(_ url: String, params: [String : Any]? = nil, headers: RequestHeader?, completion: @escaping HTTPClientResult) -> HTTPClientTask {

        let request = URLRequest.requestWithURL(URL(string: url)!, method: "GET", queryParameters: nil, bodyParameters: nil, headers: nil)
        return self.executeRequest(request, completion: completion)
    }
    
    private func executeRequest(_ request:URLRequest, completion: @escaping HTTPClientResult) -> HTTPClientTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint("ERROR \(error.localizedDescription)")
                completion(.failure(AppError.invalidResponseData(error.localizedDescription)))
            }
            else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            }
            else {
                completion(.failure(UnexpectedError()))
            }
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}

extension URLRequest {
    static func requestWithURL(_ url:URL,
                               method:String,
                               queryParameters:[String:String]?,
                               bodyParameters:[String:Any]?,
                               headers:[String:String]?) -> URLRequest {
        var theURL:URL
        if let queryParameters = queryParameters {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryParameters.map({ (key,value) in
                URLQueryItem(name: key, value: value)
            })

            theURL = (components?.url)!
        } else {
            theURL = url
        }

        var request = URLRequest(url: theURL)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let bodyParameters = bodyParameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: .prettyPrinted)
            }
            catch {
//                debugPrint(requestError)
            }
        }

        if let headers = headers {
            for (field,value) in headers {
                request.addValue(value, forHTTPHeaderField: field)
            }
        }

        return request
    }
}

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
