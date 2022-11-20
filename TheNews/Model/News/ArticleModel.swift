//
//  ArticleModel.swift


import Foundation
// MARK: - Article
struct Article: Codable, Equatable {
    let id: UUID = UUID()
    let source: Source?
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
}


extension Article {
    
    static let mock = Self(
        source: .init(
            id: "Caschys Blog",
            name: "Caschys Blog"
        ),
        author: "André Westphal",
        title: "Fitbit für Android ist mittlerweile an Health Connect angebunden",
        articleDescription: "Fitbits offizielle App für Android ist mittlerweile an Health Connect angebunden. Kürzlich bewerkstelligte Google dies auch für seine eigene App Google Fit. Bringt? Health Connect fungiert quasi als Schnittstelle, um eure Daten aus der Fitbit-App zu anderen D…",
        url: "https://stadt-bremerhaven.de/fitbit-fuer-android-ist-mittlerweile-an-health-connect-angebunden/",
        urlToImage: "https://stadt-bremerhaven.de/wp-content/uploads/2022/10/Fitbit-Sense-2-5.jpg",
        publishedAt: "2022-10-25T08:15:22Z",
        content: "Fitbits offizielle App für Android ist mittlerweile an Health Connect angebunden. Kürzlich bewerkstelligte Google dies auch für seine eigene App Google Fit. Bringt? Health Connect fungiert quasi als … [+1159 chars]"
    )
    
}
