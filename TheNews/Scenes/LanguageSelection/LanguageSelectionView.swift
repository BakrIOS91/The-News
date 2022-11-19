//
//  LanguageSelectionView.swift
//  

import SwiftUI

struct LanguageSelectionView: View {
    @Preference(\.locale) var locale
    @Preference(\.rootView) var rootView
    
    var body: some View {
        VStack(spacing: 10){
            
            Image.languageSelection
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.appMainBlue)
                .padding()
            
            Text("pleaseChooseLanguage")
                .font(.mediumWithSize18)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 10){
                ForEach(Locale.appSupported, id: \.self) { locale in
                    Button {
                        updateAppLanguage(locale: locale)
                    } label: {
                        HStack {
                            languageIcon(locale)
                                .resizable()
                                .frame(width: 35, height: 35)
                            Text("\(locale.languageCode ?? "")".localizedStringKey)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.appMainBlue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .font(.mediumWithSize18)
        .padding()
    }
    
    func languageIcon(_ locale: Locale) -> Image {
        switch locale {
        case .de:
            return Image.germany
        case .en:
            return Image.britain
        default:
            return Image("")
        }
    }
    
    func updateAppLanguage(locale: Locale){
        self.locale = locale
        Bundle.setLanguage(language: locale.languageCode ?? "")
        rootView = .home
    }
}

struct LanguageSelectionVIew_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            LanguageSelectionView()
        }
    }
}
