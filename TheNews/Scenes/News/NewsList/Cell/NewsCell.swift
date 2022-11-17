//
//  NewsCell.swift
//  TheNews
//
//  Created by Bakr mohamed on 16/11/2022.
//

import SwiftUI
import Kingfisher

struct NewsCell: View {
    var model: Article
    
    var body: some View {
        Group {
            HStack {
                
                KFImage(model.urlToImage?.toURL)
                    .placeholder {
                        Img.splash
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                    }
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment: .leading){
                    Unwrap(model.title){ title in
                        Text(title)
                            .font(.mediumWithSize14)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                    
                    HStack {
                        Unwrap(model.author){ author in
                            Text(author)
                        }
                        
                        Spacer()
                        
                        Unwrap(model.publishedAt) { publishDate in
                            Text(publishDate.date)
                        }
                        
                    }
                    .font(.regularWithSize12)
                    .lineLimit(1)
                    .padding(.top, 2)
                }
                
                Spacer()
            }
        }
        .background(
            Clr.appWhite
                .shadow(color: Clr.appBlackWithOpacity10, radius: 5)
        )
        .listRowSeparator(.hidden)
    }
}

struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(model: .mock)
    }
}
