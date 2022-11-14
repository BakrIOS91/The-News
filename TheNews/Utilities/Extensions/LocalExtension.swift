//
//  LocalExtension.swift
//

import SwiftUI

extension Locale {
    static let en: Locale = .init(identifier: "en")
    static let de: Locale = .init(identifier: "de")
    static let appSupported: [Locale] = [.en, .de]
}

extension Locale {
    var nextSupportedLocale: Locale? {
        if var idx = Self.appSupported.firstIndex(of: self) ?? Self.appSupported.firstIndex(where: { self.languageCode == $0.languageCode }) {
            idx += 1
            if idx >= Self.appSupported.count { idx = 0 }
            return Self.appSupported[idx]
        } else {
            return Self.appSupported.first
        }
    }
    
    /// Selects supported locale based on current locale
    static var bestMatching: Locale {
        switch Locale.current.identifier {
        case let id where id.starts(with: "en"): return .en
        default: return .de
        }
    }
    
    
}


extension Locale {
    
    // Arabic "ar"
    // Hebrew "he", "he_IL"
    // Persian/Farsi "fa", "fa_IR"
    // Urdu "ur", "ur_IN", "ur_PK"
    private static let rtlLanguageCodes = ["ar", "he", "he_IL", "fa", "fa_IR", "ur", "ur_IN", "ur_PK"]
    
    public var layoutDirection: LayoutDirection {
        Self.rtlLanguageCodes.contains(self.languageCode ?? "") ? .rightToLeft : .leftToRight
    }
}
