//
//  NetworkEnums.swift
//  

import UIKit

public enum AppEnvironment {
    case development
    case testing
    case live
    case staging
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum NetworkError: Error, Equatable {
    case nonHTTPResponse
    case incorrectStatusCode(_ statusCode : Int)
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case decodingError(_ error: String)
    case unknown(code: Int, error: String)
}
