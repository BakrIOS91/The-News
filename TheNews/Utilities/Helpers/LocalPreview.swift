//
//  LocalPreview.swift
//  

import SwiftUI

/// Previews view in all supported locales
struct LocalePreview<Content: View>: View {
   let content: () -> Content
    private let previewContent: [LocalePreviewContent]
    
    init(
        previewDevices: [PreviewDevice] = [],
        _ content: @escaping  () -> Content
    ) {
        self.content = content
        self.previewContent = Self.preview(forDevices: previewDevices)
    }
    
    private static func preview(
        forDevices previewDevices: [PreviewDevice]
    ) -> [LocalePreviewContent] {
        var previewContent = [LocalePreviewContent]()
        for locale in Locale.appSupported {
            guard !previewDevices.isEmpty else {
                previewContent.append(.init(device: nil, locale: locale))
                continue
            }
            for previewDevice in previewDevices {
                previewContent.append(.init(device: previewDevice, locale: locale))
            }
        }
        return previewContent
    }

    var body: some View {
        Group {
            ForEach(previewContent) { preview in
                content()
                    .locale(preview.locale)
                    .previewDisplayName("\(preview.device?.rawValue ?? "") Locale: \(preview.locale.languageCode ?? "")")
                    .if(let: preview.device) { $0.previewDevice($1) }
            }
        }
    }
}

// MARK: - LocalePreviewContent

private struct LocalePreviewContent: Identifiable {
    let id = UUID()
    let device: PreviewDevice?
    let locale: Locale
}

// MARK: - Preview devices
extension Array where Element == PreviewDevice {
    static var defaultPreviewSet: [PreviewDevice] {
        [
            PreviewDevice(rawValue: "iPhone SE (2nd generation)"),
            PreviewDevice(rawValue: "iPhone SE (2nd generation)")
        ]
    }
}
