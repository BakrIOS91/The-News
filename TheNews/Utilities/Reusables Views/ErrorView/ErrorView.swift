//
//  ErrorView.swift
//

import SwiftUI

struct ErrorView: View {
    var viewBackgroundColor: Color = Clr.appBackground
    var statusImage: Image?
    var statusTitle: LocalizedStringKey?
    var statusDescription: LocalizedStringKey?
    var mainButtonTitle: LocalizedStringKey?
    var mainButtonBackgroundColor = Clr.appMainBlue
    var mainButtonAction: (() async -> ())? = nil
    
    var secondaryButtonTitle: LocalizedStringKey?
    var secondaryButtonBackgroundColor = Color.clear
    var secondaryButtonAction: (() async -> ())? = nil
    
    var defaultSecondaryButtonWidth = UIScreen.main.bounds.width / 4
    
    
    var body: some View {
        ZStack {
            viewBackgroundColor.ignoresSafeArea()
            
            VStack(alignment: .center){
                
                Unwrap(statusImage) { image in
                    image
                        .frame(width: 150, height: 150, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom, 30)
                }
                
                Unwrap(statusTitle) { title in
                    Text(title)
                        .font(.boldWithSize16)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 14)
                }
                
                Unwrap(statusDescription) { description in
                    Text(description)
                        .font(.regularWithSize14)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding([.leading,.trailing], 30)
                        .padding(.bottom, 31)
                }
                
                HStack(spacing: 5) {
                    Unwrap(secondaryButtonTitle) { title in
                        Button {
                            Task {
                                await secondaryButtonAction?()
                            }
                        } label: {
                            Text(title)
                        }
                        .font(.regularWithSize16)
                        .frame(maxWidth: defaultSecondaryButtonWidth, maxHeight: .infinity)
                        .foregroundColor(.black)
                        .background(secondaryButtonBackgroundColor)
                    }
                    
                    Unwrap(mainButtonTitle) { title in
                        Button {
                           Task {
                               await mainButtonAction?()
                           }
                        } label: {
                            Text(title)
                        }
                        .font(.boldWithSize16)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.white)
                        .background(mainButtonBackgroundColor)
                        .cornerRadius(27)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 53)
                .padding([.leading,.trailing], 30)
                
                
            }
        }
    }
}


struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview {
            ErrorView(statusImage: Img.server,
                      statusTitle: Str.serverError.key,
                      statusDescription: "description",
                      mainButtonTitle: Str.retry.key,
                      mainButtonAction: {})
        }
    }
}
