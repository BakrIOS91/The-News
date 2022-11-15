//
//  BaseRequest.swift
//  

import Foundation

typealias Parameters = [String:Any]
typealias MultipartAttachment = (fileName: String, url: URL?, data: Data?)

protocol BaseRequestProtocol {
    var host: String { get }
    var apiPath: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var baseHeaders : [String: String] { get }
    var requestTimeOut: Float { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension BaseRequestProtocol {
    var host: String {return kBaseURL}
    var apiPath: String { return "/v2"}
    var headers: [String: String] { return [:] }
    var baseHeaders : [String:String] { return defaultHeaders }
    var requestTimeOut: Float { return 30 }
    var httpMethod: HTTPMethod { return .GET }
    var parameters: Parameters? { return [:] }
}

extension BaseRequestProtocol {
    var requestURL : String {
        return kBaseURL + apiPath + path
    }
    
    var defaultHeaders: [String: String] {
        var baseHeaders: [String: String] = [
            KeyParameters.contentTypeKey: KeyParameters.applicationJson,
            KeyParameters.accept: KeyParameters.applicationJson,
        ]
        baseHeaders += headers
        return baseHeaders
    }
    
}


protocol MultipartRequestProtocol: BaseRequestProtocol {
    var attachments: [MultipartAttachment] { get }
}
