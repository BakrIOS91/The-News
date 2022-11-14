//
//  UnImplmentedView.swift
//  TCADemo
//
//  Created by Bakr mohamed on 10/11/2022.
//

import SwiftUI

struct UnImplmentedView: View {
    var body: some View {
        VStack{
            Img.unImplemented
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(Clr.appBlackWithOpacity50)

            
            Text(Str.unImplemented.key)
                .font(.boldWithSize20)
                .foregroundColor(Clr.appBlackWithOpacity50)
        }
    }
}

struct UnImplmentedView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            UnImplmentedView()
        }
    }
}
