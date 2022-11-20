//
//  NetWorkHelper.swift

import Foundation

protocol NetworkHelper: InternetConnectionChecker {
    func failHandler(_ error: Error) -> ViewState
}

extension NetworkHelper {
    func failHandler(_ error: Error) -> ViewState {
        
        guard isConnectedToInternet() else {
            return .offline(description: "Please Connectect to the internet to enjoy our service")
        }
        
        guard let error = error as? NetworkError else {
           return .unexpected(description: "UnExpected")
        }
        
        switch error {
        case .nonHTTPResponse,
                .incorrectStatusCode(_),
                .badURL(_),
                .apiError(_,_),
                .badRequest(_,_),
                .serverError(_,_),
                .noResponse(_):
            return .serverError(description: "Server Error")
        
        case .invalidJSON(_),
                .decodingError(_),
                .unknown(_,_):
            return .unexpected(description: "UnExpected")
        case .unauthorized(_,_):
            //Should be Custom error
            return .custom(
                icon: .server,
                title: "unauthorized",
                description: "unauthorized",
                retryable: false
            )
        }
    }
}
