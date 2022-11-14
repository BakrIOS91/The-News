//
//  ViewExtension.swift
//  

import SwiftUI

extension View {
    
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    /// Sets locale and layout direction
    ///
    /// Pay attention to back button in navigation view. It will require customization as it's image direction won't change on a current screen.
    @ViewBuilder
    func locale(
        _ locale: Locale
    ) -> some View {
        self.environment(\.layoutDirection, locale.layoutDirection)
            .environment(\.locale, locale)
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
           if condition {
               transform(self)
           } else {
               self
           }
       }
    
    /// `if let` statement view modifier
    ///
    /// Example:
    ///
    ///     var color: Color?
    ///
    ///     var body: some View {
    ///         Text("Example")
    ///         .if(let: color) { $0.foregroundColor($1) }
    ///     }
    ///
    @ViewBuilder
    func `if`<Transform: View, T> (
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> Transform
    ) -> some View {
        if let optional = optional {
            transform(self, optional)
        } else {
            self
        }
    }
    
    /// `if let else` statement view modifier
    ///
    /// Example:
    ///
    ///     var color: Color?
    ///
    ///     var body: some View {
    ///         Text("Example")
    ///         .if(let: color) {
    ///             $0.foregroundColor($1)
    ///         } else: {
    ///             $0.underline()
    ///         }
    ///
    @ViewBuilder
    func `if`<Transform: View, Fallback: View, T> (
        `let` optional: T?,
        @ViewBuilder transform: (Self, T) -> Transform,
        @ViewBuilder else fallbackTransform: (Self) -> Fallback
    ) -> some View {
        if let optional = optional {
            transform(self, optional)
        } else {
            fallbackTransform(self)
        }
    }
}
