//
//  UINavigationExtenion.swift
//  

import SwiftUI

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}
