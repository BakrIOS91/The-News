//
//  UnImplmentedView.swift


import SwiftUI

struct UnImplmentedView: View {
    var body: some View {
        VStack{
            Image.unImplemented
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.appBlackWithOpacity50)

            
            Text(Str.unImplemented.key)
                .font(.boldWithSize20)
                .foregroundColor(.appBlackWithOpacity50)
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
