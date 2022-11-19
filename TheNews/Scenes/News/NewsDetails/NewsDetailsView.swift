//
//  SwiftUIView.swift
//  TheNews
//
//  Created by Bakr mohamed on 16/11/2022.
//

import SwiftUI
import Kingfisher

struct NewsDetailsView: View {
    @State private var availableSize: CGSize = .zero
    var model: Article

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                
                articleImageView
                    .frame(width: availableSize.width, height: 300, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10){
                    articleTitle
                    articleAuthor
                    articlePublishDate
                    articleSource
                    articleDescription
                }
                .padding(.horizontal, 20)
                
            }
        }
        .readSize { availableSize = $0 }
        .padding(.vertical, 10)
        .navigationTitle(Str.details.key)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Unwrap(model.url?.toURL) { shareURL in
                    Button {
                        Helpers.shared.shareSheet(url: shareURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .foregroundColor(.appMainBlue)
                }
            }
        }
    }
    
    var articleImageView: some View {
        KFImage(model.urlToImage?.toURL)
            .placeholder {
                Image.splash
                    .resizable()
            }
            .resizable()
            .background(
                Color.appWhite
                    .shadow(color: .black.opacity(0.6), radius: 5)
                
            )
    }
    
    var articleTitle: some View {
        Unwrap(model.title) { title in
            Text(title)
                .font(.boldWithSize18)
        } fallbackContent: {
            Text("N/A")
        }

    }
    
    var articleAuthor: some View {
        Unwrap(model.author) { author in
            Text(Str.author(author))
                .font(.mediumWithSize15)
        } fallbackContent: {
            Text(Str.author("N/A"))
                .font(.mediumWithSize15)
        }
    }
    
    var articlePublishDate: some View {
        Unwrap(model.publishedAt) { publishedAt in
            Text(Str.publishDate(publishedAt.date))
                .font(.mediumWithSize15)
        } fallbackContent: {
            Text(Str.publishDate("N/A"))
                .font(.mediumWithSize15)
        }
    }
    
    var articleSource: some View {
        Unwrap(model.source?.name) { sourceName in
            Text(Str.source(sourceName))
                .font(.mediumWithSize15)
        } fallbackContent: {
            Text(Str.source("N/A"))
                .font(.mediumWithSize15)
        }
    }
    
    var articleDescription: some View {
        Unwrap(model.articleDescription) { description in
            VStack(alignment: .leading, spacing: 5){
                Text(Str.description.key)
                    .font(.boldWithSize14)
                    .multilineTextAlignment(.leading)
                Divider()
                Text(description)
            }
        } fallbackContent: {
            VStack(spacing: 5){
                Text(Str.description.key)
                    .font(.mediumWithSize15)
                Divider()
                Text("N/A")
            }
        }
        .padding(.top, 20)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LocalePreview{
            NavigationView {
                NewsDetailsView(model: .mock)
            }
        }
    }
}
