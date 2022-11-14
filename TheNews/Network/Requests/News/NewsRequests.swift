//
//  NewsRequest.swift
//  IHFEduTCA
//
//  Created by Bakr mohamed on 19/10/2022.
//

import Foundation
enum NewsRequests: BaseRequestProtocol {
    case getNewsList
    case getNewsDetails(id: String)
    
    var newsPath: String {
        return "/news"
    }
    
    var path: String {
        switch self {
        case .getNewsList:
            return newsPath + "/all"
        case .getNewsDetails(let id):
            return newsPath + "/uuid/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var parameters: Parameters?{
        switch self {
        default:
            return [
                KeyParameters.apiToken: kAppAPIKey
            ]
        }
    }
}
