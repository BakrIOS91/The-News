//
//  ApiFetcher.swift
//  

/*
    1- must be check preformance against alamofire (speed/processor/battery)
    2- check multi request diffrent and same result
 
 */

import Foundation
import Combine

protocol Fetcher {
    @discardableResult
    func fetch<ResponseType: Codable > (request: BaseRequestProtocol ,responseClass: ResponseType.Type) async throws -> ResponseType
}


public final class APIFetcher: Fetcher {
    static let shared = APIFetcher()
    typealias NetworkResponse = (data: Data, response: URLResponse)

    func fetch<ResponseType>(request: BaseRequestProtocol, responseClass: ResponseType.Type) async throws -> ResponseType where ResponseType : Decodable, ResponseType : Encodable {
        //SessionConfiguration
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut)
        let decoder = JSONDecoder()
        //Handel URL
        guard let url =  URL(string: request.requestURL) else { throw NetworkError.badURL("Invalid Url") }
        //Request
        let urlRequest = generateUrlRequest(url: url, request: request)
        // response
        let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPResponse
        }
        
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? decoder.decode(responseClass.self, from: data) else {
                throw NetworkError.decodingError("Decoidng Error")
            }
            return decodedResponse
        case 401:
            throw NetworkError.unauthorized(code: 401, error: "Unothrized")
        default:
            throw NetworkError.unknown(code: 0, error: "UnExpected Error")
        }
    }
    
    fileprivate func generateUrlRequest(url: URL, request: BaseRequestProtocol) -> URLRequest {
        var urlRequest: URLRequest
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.defaultHeaders
        
        switch request.httpMethod {
        case .GET:
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            if let params = request.parameters, !params.isEmpty {
                urlComponents?.queryItems = params.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
            }
            urlRequest.url = urlComponents?.url ?? url
            
        default:
            if let params = request.parameters?.jsonData {
                urlRequest.httpBody = params
            }
        }
        
        return urlRequest
    }
    
    
    /// Use this to check about internet connection
    static var isConnectedToInternet: Bool {
        return NetworkMonitor.shared.isReachable
    }
}

protocol InternetConnectionChecker {
    func isConnectedToInternet() -> Bool
}

extension InternetConnectionChecker {
    func isConnectedToInternet() -> Bool {
        return APIFetcher.isConnectedToInternet
    }
}
