//
//  NewsService.swift

import ComposableArchitecture
import XCTestDynamicOverlay
import Foundation


struct NewsClient {
    var list: (_ query: String,_ pageIndexx: Int) async throws -> NewsList
}

extension DependencyValues {
  var newsClient: NewsClient {
    get { self[NewsClient.self] }
    set { self[NewsClient.self] = newValue }
  }
}

extension NewsClient: TestDependencyKey {
    static var previewValue: NewsClient {
        return .init(
            list: { _, _ in .mock }
        )
    }
    
    static var testValue: NewsClient {
        return .init (
        list: unimplemented("\(Self.self).List")
        )
    }
}

extension NewsClient: DependencyKey {
    static let liveValue = NewsClient (
        list: { query, pageIndex in
            let request = NewsRequests.getNewsList(query: query, pageIndex: pageIndex, pageSize: kAppPageSize)
            return try await APIFetcher.shared.fetch(request: request, responseClass: NewsList.self)
        }
    )
}
