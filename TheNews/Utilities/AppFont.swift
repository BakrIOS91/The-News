//
//  AppFont.swift
//  

import SwiftUI

enum AppFont: String {
    
    case bold
    case medium
    case regular
    case semiBold
    
    func with(size: CGFloat) -> Font {
         let font = Font.custom("Montserrat-\(self.rawValue.capitalizingFirstLetter())", size: size)
        return  font
    }
    
}

extension Font {
    // Regular
    static let regularWithSize10 = AppFont.regular.with(size: 10)
    static let regularWithSize12 = AppFont.regular.with(size: 12)
    static let regularWithSize13 = AppFont.regular.with(size: 13)
    static let regularWithSize14 = AppFont.regular.with(size: 14)
    static let regularWithSize15 = AppFont.regular.with(size: 15)
    static let regularWithSize16 = AppFont.regular.with(size: 16)
    static let regularWithSize17 = AppFont.regular.with(size: 17)
    static let regularWithSize18 = AppFont.regular.with(size: 18)
    static let regularWithSize20 = AppFont.regular.with(size: 20)
    
    // medium
    static let mediumWithSize10 = AppFont.medium.with(size: 10)
    static let mediumWithSize12 = AppFont.medium.with(size: 12)
    static let mediumWithSize14 = AppFont.medium.with(size: 14)
    static let mediumWithSize15 = AppFont.medium.with(size: 15)
    static let mediumWithSize16 = AppFont.medium.with(size: 16)
    static let mediumWithSize17 = AppFont.medium.with(size: 17)
    static let mediumWithSize18 = AppFont.medium.with(size: 18)
    static let mediumWithSize20 = AppFont.medium.with(size: 20)
    
    // Bold
    static let boldWithSize10 = AppFont.bold.with(size: 10)
    static let boldWithSize12 = AppFont.bold.with(size: 12)
    static let boldWithSize14 = AppFont.bold.with(size: 14)
    static let boldWithSize15 = AppFont.bold.with(size: 15)
    static let boldWithSize16 = AppFont.bold.with(size: 16)
    static let boldWithSize18 = AppFont.bold.with(size: 18)
    static let boldWithSize20 = AppFont.bold.with(size: 20)
    
    //semibold
    static let semiBoldWithSize10 = AppFont.semiBold.with(size: 10)
    static let semiBoldWithSize12 = AppFont.semiBold.with(size: 12)
    static let semiBoldWithSize14 = AppFont.semiBold.with(size: 14)
    static let semiBoldWithSize15 = AppFont.semiBold.with(size: 15)
    static let semiBoldWithSize16 = AppFont.semiBold.with(size: 16)
    static let semiBoldWithSize18 = AppFont.semiBold.with(size: 18)
    static let semiBoldWithSize20 = AppFont.semiBold.with(size: 20)

}
