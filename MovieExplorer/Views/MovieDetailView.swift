//
//  MovieDetailView.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI
import Kingfisher


struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                KFImage(movie.posterURL)
                    .placeholder {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.appCardBackground)
                            .frame(height: 500)
                    }
                    .fade(duration: 0.5) 
                    .onSuccess { result in
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.3), radius: 10)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.titleFont)
                        .foregroundColor(Color.appPrimary)
                    
                    Text("Released: \(movie.releaseYear)")
                        .font(.subtitleFont)
                        .foregroundColor(Color.appPrimary)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Overview")
                        .font(.subtitleFont)
                        .foregroundColor(Color.appPrimary)
                    
                    Text(movie.overview ?? "No overview available.")
                        .font(.bodyFont)
                        .foregroundColor(Color.appPrimary)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 16)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
