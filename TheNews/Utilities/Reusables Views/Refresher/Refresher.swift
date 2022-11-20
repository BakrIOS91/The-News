//
//  Refresher.swift

import SwiftUI


struct Refresher<Content: View>: View {
    var content: Content
    var showingScrollIndicator: Bool
    
    // MARK: Async Call Back
    var onRefresh: () async -> ()
    
    // MARK: Scroll Coordinate Space Name
    fileprivate let scrollCoordinateSpaceName = "Scroll"
    
    // MARK: Scroll Delgate
    @StateObject var scrollDelgate: ScrollViewModel = .init()

    init(
        showingScrollIndicator: Bool = false,
        @ViewBuilder content: @escaping () -> Content,
        onRefresh: @escaping () async -> ()
    ) {
        self.showingScrollIndicator = showingScrollIndicator
        self.content = content()
        self.onRefresh = onRefresh
    }
           
    var body: some View {
        ScrollView(.vertical, showsIndicators: showingScrollIndicator){
            VStack(spacing: 0) {
                progressView
                    .scaleEffect(scrollDelgate.isEligble ? 1 : 0.001)
                    .animation(.easeInOut(duration: 0.2), value: scrollDelgate.isEligble)
                    .overlay {
                        VStack(spacing: 10) {
                            Image(systemName: "arrow.down")
                                .font(.boldWithSize14)
                                .foregroundColor(.white)
                                .rotationEffect(.init(degrees: scrollDelgate.progress * 180))
                                .padding(8)
                                .background(.primary, in: Circle())
                            
                            Text(Str.pullToRefresh.key)
                                .font(.boldWithSize14)
                                .foregroundColor(.primary)
                        }
                        .opacity(scrollDelgate.isEligble ? 0 : 1)
                        .animation(.easeInOut(duration: 0.25), value: scrollDelgate.isEligble)
                    }
                    .frame(height: 100 * scrollDelgate.progress)
                    .opacity(scrollDelgate.progress)
                    .offset(y: scrollDelgate.isEligble ? -(scrollDelgate.contentOffset < 0 ? 0 : scrollDelgate.contentOffset) : -(scrollDelgate.scrollOffset < 0 ? 0 : scrollDelgate.scrollOffset))
                                
                content
            }
            .offset(coordinateSpaceName: scrollCoordinateSpaceName) { offset in
                // MARK: Storing Content Offset
                scrollDelgate.contentOffset = offset
                // MARK: Stopping the progress when it is eligiable for refresh
                if !scrollDelgate.isEligble {
                    var progress = offset / 100
                    progress = (progress < 0 ? 0 : progress)
                    progress = (progress > 1 ? 1 : progress)
                    scrollDelgate.scrollOffset = offset
                    scrollDelgate.progress = progress
                }
                
                if scrollDelgate.isEligble && !scrollDelgate.isRefreshing {
                    scrollDelgate.isRefreshing = true
                    UIImpactFeedbackGenerator.init(style: .medium).impactOccurred()
                }
            }
            .onAppear { scrollDelgate.addGesture() }
            .onDisappear {  scrollDelgate.removeGesture() }
            .onChange(of: scrollDelgate.isRefreshing) { newValue in
                // MARK: calling Async Method
                if newValue {
                    Task {
                         await onRefresh()
                        // MARK: Ressting Back after refresh done
                        withAnimation(.easeIn(duration: 0.25)) {
                            scrollDelgate.progress = 0
                            scrollDelgate.scrollOffset = 0
                            scrollDelgate.isEligble = false
                            scrollDelgate.isRefreshing = false
                        }
                    }
                }
            }
        }
        .coordinateSpace(name: scrollCoordinateSpaceName)
    }
    
    var progressView: some View {
        // MARK: Change It whatever Loader style you like
        ProgressView()
            .progressViewStyle(.circular)
            .frame(width: 200, height: 200)
    }
}


struct Refresher_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            Refresher {
                Text(Str.pullToRefresh.key)
                    .font(.boldWithSize14)
                    .foregroundColor(.primary)
            } onRefresh: {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
            }
        }
    }
    
}

// MARK: For Simultanious Pan Gesture
final class ScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    // MARK: Properties
    @Published var isEligble: Bool = false
    @Published var isRefreshing: Bool = false
    // MARK: Progress and Offset
    @Published var progress: CGFloat = 0
    @Published var scrollOffset: CGFloat = 0
    @Published var contentOffset: CGFloat = 0
    
    // MARK: Scince we need to know when the user left the screen to start loading
    // Adding pan gesture to main application window
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: Add gesture
    func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange))
        panGesture.delegate = self
        
        rootViewController().view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Remove Gesture when Leaving the view
    func removeGesture() {
        rootViewController().view.gestureRecognizers?.removeAll()
    }
    
    @objc
    func onGestureChange(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .cancelled || gesture.state == .ended {
            if !isRefreshing {
                isEligble = scrollOffset > 100 ? true : false
            }
        }
    }
    
    // MARK: finding RootViewController
    func rootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}

// MARK: Offset Prefrance Key
struct OffsetPrefranceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

// MARK: Offset Modifire
extension View {
    @ViewBuilder
    func offset(
        coordinateSpaceName: String,
        offset: @escaping (CGFloat) -> ()
    ) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named(coordinateSpaceName)).minY
                    Color.clear
                        .preference(key: OffsetPrefranceKey.self, value: minY)
                        .onPreferenceChange(OffsetPrefranceKey.self) { value in
                            offset(value)
                        }
                }
            }
    }
}
