//
//  StringExtension.swift
//

import SwiftUI

extension String {
    
    var localizedStringKey: LocalizedStringKey {
        .init(self)
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        guard let date = dateFormatter.date(fromString: self, withFormat: .yyyyMMddTHHmmssZ)?.toLocalTime() else {return ""}
        return dateFormatter.string(fromDate: date, withFormate: .dMMMyyyy)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var toURL: URL? {
        return URL(string: self)
    }
    
    func replaceEmpty() -> String {
        if self.isEmpty {
            return "N/A"
        }
        
        return self
    }
}
