//
//  AppEnums.swift
//  

import SwiftUI

enum AppRootView: Codable {
    case splash
    case language
    case home
}

enum ViewState: Equatable {
    case loaded
    case loading
    case noData(description: LocalizedStringKey)
    case offline(description: LocalizedStringKey)
    case serverError(description: LocalizedStringKey)
    case unexpected(description: LocalizedStringKey)
    case custom(icon: Image, title: LocalizedStringKey, description: LocalizedStringKey, retryable: Bool)
}

enum PageIndex {
    case first
    case next
}
