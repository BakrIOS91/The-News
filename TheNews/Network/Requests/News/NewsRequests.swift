//
//  NewsRequest.swift


import Foundation
enum NewsRequests: BaseRequestProtocol {
    case getNewsList(query: String, pageIndex: Int, pageSize: Int)
    
    var path: String {
        switch self {
        case .getNewsList:
            return "/everything"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getNewsList(_,_,_):
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .getNewsList(let query, let pageIndex, let pageSize):
            return [
                "q": query,
                "language": Locale.bestMatching.identifier,
                "apiKey": kAppAPIKey,
                "pageSize": pageSize,
                "page": pageIndex
            ]
        }
    }
}
