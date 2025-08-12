//
//  MovieListViewModel.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import SwiftUI
import SwiftData
import Alamofire

class MovieListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    
    var modelContext: ModelContext?
    private let networkManager: NetworkManaging 

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    @MainActor
    func fetchMovies() async {
        isLoading = true
        error = nil

        do {
            let movieResponse: MovieListResponse = try await networkManager.fetchData(from: .popularMovies)
            
            let existingMovieIDs = Set(try await modelContext?.fetch(FetchDescriptor<Movie>()).map { $0.id } ?? [])
            
            for movie in movieResponse.results {
                if !existingMovieIDs.contains(movie.id) {
                    modelContext?.insert(movie)
                }
            }
        } catch {
            self.error = error
        }

        isLoading = false
    }
}
