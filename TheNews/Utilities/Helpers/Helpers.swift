//
//  Helpers.swift
//  TCADemo
//
//  Created by Bakr mohamed on 10/11/2022.
//

import Foundation

struct Helpers {
    static let shared = Helpers()
    
    func wait(_ duration: Double = 2, _ action: @escaping(() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: action)
    }
    
}
