// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// MARK: - Strings

public enum Str {
  /// Deutsch
  public static let de = LocalizedString(table: "Localizable", lookupKey: "de")
  /// English
  public static let en = LocalizedString(table: "Localizable", lookupKey: "en")
  /// Fetching new records......
  public static let fetchingNewRecords = LocalizedString(table: "Localizable", lookupKey: "fetchingNewRecords")
  /// Home
  public static let home = LocalizedString(table: "Localizable", lookupKey: "home")
  /// Language
  public static let language = LocalizedString(table: "Localizable", lookupKey: "language")
  /// Load More
  public static let loadMore = LocalizedString(table: "Localizable", lookupKey: "loadMore")
  /// News
  public static let news = LocalizedString(table: "Localizable", lookupKey: "News")
  /// Please try different keyword
  public static let noDataDescription = LocalizedString(table: "Localizable", lookupKey: "noDataDescription")
  /// No items to display
  public static let noDataFound = LocalizedString(table: "Localizable", lookupKey: "noDataFound")
  /// Not authorized
  public static let notAuthorized = LocalizedString(table: "Localizable", lookupKey: "notAuthorized")
  /// Please check your internet connection
  public static let pleaseCheckYourInternetConnections = LocalizedString(table: "Localizable", lookupKey: "pleaseCheckYourInternetConnections")
  /// Please choose your desired language
  public static let pleaseChooseLanguage = LocalizedString(table: "Localizable", lookupKey: "pleaseChooseLanguage")
  /// Please try again later
  public static let pleaseTryAgainLater = LocalizedString(table: "Localizable", lookupKey: "pleaseTryAgainLater")
  /// Pull to Refresh
  public static let pullToRefresh = LocalizedString(table: "Localizable", lookupKey: "pullToRefresh")
  /// Retry
  public static let retry = LocalizedString(table: "Localizable", lookupKey: "retry")
  /// Ex. Sunflower
  public static let searchPlaceHolder = LocalizedString(table: "Localizable", lookupKey: "searchPlaceHolder")
  /// Server error
  public static let serverError = LocalizedString(table: "Localizable", lookupKey: "serverError")
  /// Settings
  public static let settings = LocalizedString(table: "Localizable", lookupKey: "settings")
  /// Server sent no data
  public static let unableToLoadThePageServerSentNoData = LocalizedString(table: "Localizable", lookupKey: "unableToLoadThePageServerSentNoData")
  /// Error occurred
  public static let unexpectedError = LocalizedString(table: "Localizable", lookupKey: "unexpectedError")
  /// unImplemented
  public static let unImplemented = LocalizedString(table: "Localizable", lookupKey: "unImplemented")
  /// You are not authorized to access this page
  public static let youAreNotAuthorized = LocalizedString(table: "Localizable", lookupKey: "youAreNotAuthorized")
  /// You are offline
  public static let youAreOffline = LocalizedString(table: "Localizable", lookupKey: "youAreOffline")
}

// MARK: - Implementation Details
fileprivate func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
  let path = Bundle.main.path(forResource: Locale.current.identifier, ofType: "lproj") ?? ""
  let format: String
  if let bundle = Bundle(path: path) {
    format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
  } else {
    format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
  }
  return String(format: format, locale: Locale.current, arguments: args)
}

public struct LocalizedString: Hashable {
  let table: String
  fileprivate let lookupKey: String

  init(table: String, lookupKey: String) {
    self.table = table
    self.lookupKey = lookupKey
  }

  var key: LocalizedStringKey {
    LocalizedStringKey(lookupKey)
  }

  var text: String {
    tr(table, lookupKey)
  }
}


private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
      return Bundle.module
    #else
      return Bundle(for: BundleToken.self)
    #endif
  }()
}
