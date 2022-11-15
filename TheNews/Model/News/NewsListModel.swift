//
//  NewsListModel.swift
//  TheNews
//
//  Created by Bakr mohamed on 15/11/2022.
//

import Foundation

// MARK: - NewsList
struct NewsList: Codable {
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
            .mock,
            .mock,
            .mock,
        ]
    )
}
