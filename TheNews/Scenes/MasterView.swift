//
//  MasterView.swift
//  

import SwiftUI

struct MasterView: View {
    @Preference(\.rootView) var rootView
    
    var body: some View {
        LocalizedContentView {
            masterRootView
        }
    }
    
    @ViewBuilder
    var masterRootView: some View {
        switch rootView {
        case .splash:
            SplashView()
        case .language:
            LanguageSelectionView()
        case .home:
            TabBarView()
        default:
            UnImplmentedView()
        }
    }
}
