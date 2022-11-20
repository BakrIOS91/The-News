//
//  WithViewSate.swift

import SwiftUI

struct WithViewState<Content: View, LoadingContent: View>: View {
    var viewState: ViewState
    let content: Content
    let loadingContent: LoadingContent
    var retryHandler: () async -> ()
    var isRefreshable: Bool
    
    init(
        _ viewState: ViewState,
        isRefreshable: Bool,
        @ViewBuilder content: () -> Content,
        @ViewBuilder loadingContent: () -> LoadingContent,
        retryHandler: @escaping () async -> ()
    ) {
        self.viewState = viewState
        self.isRefreshable = isRefreshable
        self.content = content()
        self.loadingContent = loadingContent()
        self.retryHandler = retryHandler
    }
    
    var body: some View {
        switch viewState {
        case .loaded:
            content
                .if(isRefreshable) { view in
                    view.refreshable {
                            await retryHandler()
                        }
                }
            
        case .loading:
            loadingContent
                .if(isRefreshable) { view in
                    view.refreshable {
                            await retryHandler()
                        }
                }
        case .noData(let description):
            ErrorView(
                statusImage: .nodataError,
                statusTitle: Str.noDataFound.key,
                statusDescription: description
            )
        case .offline(let description):
            ErrorView(
                statusImage: .noNetworkErr,
                statusTitle: Str.youAreOffline.key,
                statusDescription: description,
                mainButtonTitle: Str.retry.key,
                mainButtonAction: retryHandler
            )
        case .serverError(let description):
            ErrorView(
                statusImage: .server,
                statusTitle: Str.serverError.key,
                statusDescription: description,
                mainButtonTitle: Str.retry.key,
                mainButtonAction: retryHandler
            )
        case .unexpected(let description):
            ErrorView(
                statusImage: .server,
                statusTitle: Str.unexpectedError.key,
                statusDescription: description,
                mainButtonTitle: Str.retry.key,
                mainButtonAction: retryHandler
            )
        case .custom(let icon, let title, let description, let retryable):
            if retryable {
                ErrorView(
                    statusImage: icon,
                    statusTitle: title,
                    statusDescription: description,
                    mainButtonTitle: Str.retry.key,
                    mainButtonAction: retryHandler
                )
            } else {
                ErrorView(
                    statusImage: icon,
                    statusTitle: title,
                    statusDescription: description
                )
            }
        }
    }
}


struct WithViewSate_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            WithViewState(
                .loading,
                isRefreshable: true
            ) {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    
                    Spacer()
                }
                .padding()
            } loadingContent: {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                }
                .padding()
                .redacted(reason: .placeholder)
            } retryHandler: {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
            }
        }
        
    }
}
