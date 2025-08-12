//
//  HeroMovieView.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct HeroMovieView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            KFImage(movie.posterURL)
                .resizable()
                .placeholder { Color.appCardBackground }
                .fade(duration: 0.25)
                .scaledToFill()
            .frame(height: 350)
            .clipped()
            .overlay(
                Text(movie.title)
                    .font(.titleFont)
                    .foregroundColor(.appPrimary)
                    .lineLimit(2)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(LinearGradient(
                        colors: [.clear, .black.opacity(0.7)],
                        startPoint: .top, endPoint: .bottom
                    ))
                , alignment: .bottomLeading
            )
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.5), radius: 10)
        }
        .padding(.horizontal)
    }
}
