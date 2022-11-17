//
//  NewsListView.swift
//  TheNews
//
//  Created by Bakr mohamed on 15/11/2022.
//

import SwiftUI
import ComposableArchitecture


struct NewsListView: View {
    @State var searchQuery: String = ""
    let store: StoreOf<NewsListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                WithViewState(viewStore.viewState, isRefreshable: true) {
                    List {
                        ForEach(viewStore.newsList, id: \.id){ article in
                            NewsCell(model: article)
                                .frame(height: 90)
                                .onTapGesture {
                                    viewStore.send(.didSelectArticle(article: article))
                                }
                        }
                        
                        if viewStore.state.shouldPaginate {
                            Text(Str.fetchingNewRecords.key)
                                .font(.regularWithSize12)
                                .onAppear{
                                    Helpers.shared.wait {
                                        viewStore.send(.getNextPageIfNeeded)
                                    }
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    
                } loadingContent: {
                    ScrollView {
                        ForEach((0...10), id: \.self) { _ in
                            NewsCell(model: .mock)
                        }
                    }
                    .redacted(reason: .placeholder)
                    .padding()
                } retryHandler: {
                    viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
                }
                .navigationTitle(Str.news.key)
                .navigationViewStyle(.stack)
                .navigation(
                    item:
                        viewStore.binding(
                            get: \.selectedArticle,
                            send: .didSelectArticle(article: nil)
                        )
                ) {
                    NewsDetailsView(model: $0)
                }
            }
            .onAppear{
                viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
            }
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery) { newValue in
                viewStore.send(.fetchNews(query: searchQuery, atPage: .first))
            }
        }
    }
}
struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview {
            NewsListView(store:
                    .init(
                        initialState: NewsListFeature.State(),
                        reducer: NewsListFeature()
                    )
            )
        }
    }
}
