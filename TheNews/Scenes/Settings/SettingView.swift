//
//  SettingView.swift
//  

import SwiftUI

struct SettingView: View {
    @Preference(\.locale) var locale
    
    var body: some View {
        VStack{
            Text("settings")
                .font(.boldWithSize20)
                .padding()
            Divider()
            
            Button(action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }, label: {
                HStack{
                    Text("language")
                    Spacer()
                    HStack{
                        Text("\(locale?.languageCode ?? "")".localizedStringKey)
                        Image(systemName: "chevron.forward")
                    }
                }
            })
            .foregroundColor(.black)
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            SettingView()
        }
    }
}
