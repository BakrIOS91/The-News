//
//  TheNewsApp.swift
//  TheNews
//
//  Created by Bakr mohamed on 14/11/2022.
//

import SwiftUI

@main
struct TheNewsApp: App {
    @Preference(\.locale) var locale
    
    init(){
        NetworkMonitor.shared.startMonitoring()
        self.locale = Locale(identifier: Bundle.main.preferredLocalizations.first ?? "en")
    }
    
    var body: some Scene {
        WindowGroup {
            MasterView()
        }
    }
}
