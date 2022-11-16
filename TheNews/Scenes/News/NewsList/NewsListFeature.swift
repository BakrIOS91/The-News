//
//  NewsListFeature.swift
//  TheNews
//
//  Created by Bakr mohamed on 15/11/2022.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct NewsListFeature: ReducerProtocol, NetworkHelper {
    
    @Dependency(\.newsClient) var newsClient

    struct State: Equatable {
        var query: String = ""
        var pageIndex: Int = 1
        var shouldPaginate: Bool = false
        var viewState: ViewState = .loading
        var newsList: [Article] = []
        var totalNewsItem: Int = 0
    }
    
    enum Action: Equatable {
        case fetchNews(query: String, atPage: PageIndex)
        case newsListResponse(TaskResult<NewsList>)
        case getNextPageIfNeeded
    }
        
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchNews(let query, let atPage):
            guard isConnectedToInternet() else {
                state.viewState = .offline(description: Str.youAreOffline.key)
                return .none
            }
            
            if atPage == .first {
                if state.newsList.isEmpty {
                    state.viewState = .loading
                }
                state.pageIndex = 1
            } else {
                state.pageIndex += 1
            }
            
            return .task { [pageIndex = state.pageIndex] in
                await .newsListResponse(
                    TaskResult {
                        try await self.newsClient.list(query.isEmpty ? "all" : query, pageIndex)
                    })
            }
        case .newsListResponse(.success(let response)):
            state.totalNewsItem = response.totalResults ?? 0
            if let articles = response.articles {
                if state.pageIndex == 1 , articles.isEmpty {
                    state.viewState = .noData(description: "")
                    state.newsList.removeAll()
                } else {
                    if state.pageIndex == 1 { state.newsList.removeAll() }
                    state.newsList.append(contentsOf: articles)
                    state.viewState = .loaded
                }
                state.shouldPaginate = response.totalResults ?? 0 > state.newsList.count
            } else {
                state.viewState = .serverError(description: "")
            }
            return .none
        case .newsListResponse(.failure( let error)):
            state.viewState = failHandler(error)
            return .none
        case .getNextPageIfNeeded:
            if state.newsList.count < state.totalNewsItem && state.shouldPaginate {
                return .task { [query = state.query] in
                    .fetchNews(query: query, atPage: .next)
                }
            } else {
                state.shouldPaginate = false
            }
            return .none
        }
    }
}
