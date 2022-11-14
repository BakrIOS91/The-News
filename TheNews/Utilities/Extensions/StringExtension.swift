//
//  StringExtension.swift
//

import SwiftUI

extension String {
    
    var localizedStringKey: LocalizedStringKey {
        .init(self)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }
    
    func replaceEmpty() -> String {
        if self.isEmpty {
            return "N/A"
        }
        
        return self
    }
}
