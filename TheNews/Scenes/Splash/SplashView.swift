//
//  SplashView.swift
//  

import SwiftUI

struct SplashView: View {
    @Preference(\.rootView) var rootView
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Img.splash
                .resizable()
                .frame(height: 150)
            
            Spacer()
            
            ProgressView()
                .progressViewStyle(.circular)
                .padding(.bottom, 30)
    
        }
        .padding()
        .onAppear {
            Helpers.shared.wait {
                rootView = .language
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            SplashView()
        }
        
    }
}
