//
//  TabBarView.swift
//  

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NewsListView(store:
                    .init(
                        initialState: NewsListFeature.State(),
                        reducer: NewsListFeature()
                    )
            )
            .tabItem {
                Label("home", systemImage: "house.fill")
            }
            
            //gear
            SettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gear")
                        Text("settings")
                    }
                }
        }
        .onAppear() {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.blue.opacity(0.2))
            
            // Use this appearance when scrolling behind the TabView:
            UITabBar.appearance().standardAppearance = appearance
            // Use this appearance when scrolled all the way up:
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            TabBarView()
        }
    }
}
