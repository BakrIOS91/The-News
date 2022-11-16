//
//  NewsListView.swift
//  TheNews
//
//  Created by Bakr mohamed on 15/11/2022.
//

import SwiftUI
import ComposableArchitecture


struct NewsListView: View {
    let store: StoreOf<NewsListFeature>
    @State var searchQuery: String = ""
    
    var body: some View {
        ZStack {
            Clr.appRed.ignoresSafeArea()
            
            WithViewStore(store) { viewStore in
                NavigationView {
                    WithViewState(viewStore.viewState, isRefreshable: true) {
                        List {
                            ForEach(viewStore.newsList, id: \.id){ newsItem in
                                NewsCell(model: newsItem)
                                    .frame(height: 90)
                            }
                            
                            if viewStore.state.shouldPaginate {
                                Text("featching New Records....")
                                    .onAppear{
                                        viewStore.send(.getNextPageIfNeeded)
                                    }
                                    .isHidden(!viewStore.shouldPaginate)
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
                    .navigationTitle("News")
                    .navigationViewStyle(.stack)
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
