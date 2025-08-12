//
//  ContentView.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = MovieListViewModel()
    
    @State private var searchText: String = ""
    
    @Query(sort: \Movie.title, order: .forward) private var movies: [Movie]
    
    var filteredMovies: [Movie] {
        guard !searchText.isEmpty else { return movies }
        return movies.filter { $0.title.localizedStandardContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                if viewModel.isLoading && movies.isEmpty {
                    ProgressView().tint(Color.appAccent)
                        .transition(.opacity)
                } else if movies.isEmpty {
                    ContentUnavailableView("No movies available.", systemImage: "film.fill")
                        .foregroundStyle(Color.appSecondary)
                        .transition(.opacity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            if let heroMovie = filteredMovies.first {
                                NavigationLink(destination: MovieDetailView(movie: heroMovie)) {
                                    HeroMovieView(movie: heroMovie)
                                }
                                .buttonStyle(.plain)
                            }
                            
                            Text("Trending Now")
                                .font(.subtitleFont)
                                .foregroundColor(Color.appPrimary)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(filteredMovies.dropFirst()) { movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            MovieHorizontalItem(movie: movie)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchMovies()
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.isLoading) 
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Movie Explorer")
                        .font(.titleFont)
                        .foregroundColor(Color.appPrimary)
                }
            }
            .accentColor(Color.appPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.appBackground, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear {
                viewModel.modelContext = modelContext
                if movies.isEmpty {
                    Task {
                        await viewModel.fetchMovies()
                    }
                }
            }
        }
    }
}
