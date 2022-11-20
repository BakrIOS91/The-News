//
//  UnWrap.swift


import SwiftUI

public struct Unwrap<Value, Content: View, FallbackContent: View>: View {
    let value: Value?
    let contentProvider: (Value) -> Content
    let fallbackContentProvider: (() -> FallbackContent)?

    public init(
        _ value: Value?,
        @ViewBuilder content: @escaping (Value) -> Content,
        @ViewBuilder fallbackContent: @escaping () -> FallbackContent
    ) {
        self.value = value
        self.fallbackContentProvider = fallbackContent
        self.contentProvider = content
    }

    public var body: some View {
        if value == nil {
            fallbackContentProvider?()
        } else {
            value.map(contentProvider)
        }
    }
}

extension Unwrap where FallbackContent == Never {
    public init(
        _ value: Value?,
        @ViewBuilder content: @escaping (Value) -> Content
    ) {
        self.value = value
        self.fallbackContentProvider = nil
        self.contentProvider = content
    }
}
