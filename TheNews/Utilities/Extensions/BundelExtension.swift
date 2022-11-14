//
//  BundelExtension.swift
//  

import Foundation
fileprivate var kBundleKey = 0
class BundleExtenstion : Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let string = (objc_getAssociatedObject(self, &kBundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return string
        
    }
}

extension Bundle {
    
//    static var locale: Locale? {
//        guard UserDefaults.standard.array(forKey: "AppleLanguages") is [Locale] else { return nil }
//        return .bestMatching
//        }
//    
    /// override main bundle class (once in the app life) to make new localizedString func work
    static let once_action : Void = {
        object_setClass(Bundle.main, BundleExtenstion.self)
    }()
    
    static public func setLanguage(language : String) {
        Bundle.once_action
        UserDefaults.standard.set([language], forKey: kAppleLanguage) // Apple UserDefault for Language
        UserDefaults.standard.synchronize()
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            print("Failed to get a bundle path.")
            return
        }
        
        objc_setAssociatedObject(Bundle.main, &kBundleKey, Bundle(path: path), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        
    }
}
