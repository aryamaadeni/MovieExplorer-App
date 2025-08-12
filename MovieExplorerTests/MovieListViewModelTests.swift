//
//  MovieListViewModelTests.swift
//  MovieExplorerTests
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import Testing
import SwiftData
import XCTest
@testable import MovieExplorer

// MARK: - Mock Network Manager
class MockNetworkManager: NetworkManaging {
    var shouldSucceed = true
    var mockResponse: MovieListResponse?
    
    enum MockError: Error, Equatable {
        case failed
    }

    func fetchData<T: Codable>(from endpoint: NetworkManager.Endpoint) async throws -> T {
        if shouldSucceed, let response = mockResponse as? T {
            return response
        } else {
            throw MockError.failed
        }
    }
}

// MARK: - Test Suite
@Suite final class MovieListViewModelTests {
    
    // Helper to create a fresh ViewModel + in-memory container
    private func makeTestViewModel(mockManager: MockNetworkManager) throws -> (MovieListViewModel, ModelContainer) {
        let viewModel = MovieListViewModel(networkManager: mockManager)
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)
        viewModel.modelContext = ModelContext(container)
        return (viewModel, container)
    }

    @Test func testFetchMovies_Success() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        let viewModel = MovieListViewModel(networkManager: mockManager)

        // Create mock data
        let mockMovie = Movie(
            id: 1,
            title: "Mock Movie",
            overview: "A great mock movie.",
            posterPath: "/mockposter.jpg",
            releaseDate: "2023-01-01"
        )
        
        mockManager.mockResponse = MovieListResponse(page: 1, results: [mockMovie], totalPages: 1, totalResults: 1)
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Movie.self, configurations: config)
        
        viewModel.modelContext = await container.mainContext
        
        // Act
        await viewModel.fetchMovies()
        
        try await container.mainContext.save()
        
        // Assert
        #expect(!viewModel.isLoading)
        #expect(viewModel.error == nil)
        
        let movies = try await container.mainContext.fetch(FetchDescriptor<Movie>())
        #expect(movies.count == 1)
        #expect(movies.first?.title == "Mock Movie")
    }

    @Test func testFetchMovies_Failure() async throws {
        // Arrange
        let mockManager = MockNetworkManager()
        mockManager.shouldSucceed = false
        let (viewModel, _) = try makeTestViewModel(mockManager: mockManager)
        
        // Act
        await viewModel.fetchMovies()
        
        // Assert
        #expect(!viewModel.isLoading)
        #expect(viewModel.error as? MockNetworkManager.MockError == .failed)
    }
}
