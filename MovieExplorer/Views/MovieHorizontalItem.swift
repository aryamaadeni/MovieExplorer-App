//
//  MovieHorizontalItem.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct MovieHorizontalItem: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(movie.posterURL)
                .resizable()
                .placeholder { Color.appCardBackground }
                .fade(duration: 0.25)
                .scaledToFill()
            .frame(width: 120, height: 180)
            .cornerRadius(8)
            
            Text(movie.title)
                .font(.captionFont)
                .foregroundColor(.appPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
        .frame(width: 120)
    }
}
