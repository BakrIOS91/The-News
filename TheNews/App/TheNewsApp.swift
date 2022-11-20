//
//  TheNewsApp.swift


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
