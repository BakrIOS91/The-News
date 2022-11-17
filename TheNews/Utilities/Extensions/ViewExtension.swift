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
    
    
    /// Navigation view modifier
    ///
    /// Example:
    ///
    ///     @State private var nextScreenviewModel: ViewModel?
    ///
    ///     var body: some View {
    ///         Text("Example")
    ///         .navigation(item: $nextScreenviewModel) { NextScreenView(viewModel: $0) }
    ///     }
    ///
    func navigation<Item, Destination: View>(
        item: Binding<Item?>,
        @ViewBuilder destination: (Item) -> Destination
    ) -> some View {
        let isActive = Binding(
            get: { item.wrappedValue != nil },
            set: { value in if !value { item.wrappedValue = nil } }
        )
        return navigation(isActive: isActive) {
            item.wrappedValue.map(destination)
        }
    }
    
    /// Navigation view modifier
    ///
    /// Example:
    ///
    ///     @State private var isShowingView = false
    ///
    ///     var body: some View {
    ///         Text("Example")
    ///         .navigation(isActive: $isShowingView) { Text("Another screen") }
    ///     }
    ///
    func navigation<Destination: View>(
        isActive: Binding<Bool>,
        @ViewBuilder destination: () -> Destination
    ) -> some View {
        overlay(
            NavigationLink(
                destination: isActive.wrappedValue ? destination() : nil,
                isActive: isActive,
                label: { EmptyView() }
            )
        )
    }
    
    /// Reads view size with geometry reader
    func readSize(
        onChange: @escaping (CGSize) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    /// Reads view frame with geometry reader
    func readFrame(
        space: CoordinateSpace,
        onChange: @escaping (CGRect) -> Void
    ) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: FramePreferenceKey.self, value: geometryProxy.frame(in: space))
            }
        )
            .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(
    value: inout CGSize,
    nextValue: () -> CGSize
  ) {}
}

private struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(
        value: inout CGRect,
        nextValue: () -> CGRect
    ) {}
}
