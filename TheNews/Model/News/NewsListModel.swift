//
//  NewsListModel.swift


import Foundation

// MARK: - NewsList
struct NewsList: Codable, Equatable{
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

extension NewsList {
    
    static let mock = Self(
        status: "ok",
        totalResults: 12,
        articles: [
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock,
            .mock
        ]
    )
}
