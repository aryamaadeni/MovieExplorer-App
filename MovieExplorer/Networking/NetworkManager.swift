//
//  NetworkManager.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    
    private let readAccessToken = SecretsManager.shared.tmdbReadAccessToken
    private static let baseURL = "https://api.themoviedb.org/3"
    
    private init() {}
    
    enum Endpoint {
        case popularMovies
        
        var path: String {
            switch self {
            case .popularMovies:
                return "/movie/popular"
            }
        }
    }
    
    func fetchData<T: Codable>(from endpoint: Endpoint) async throws -> T {
        let url = "\(NetworkManager.baseURL)\(endpoint.path)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(readAccessToken)",
            "Accept": "application/json"
        ]
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, headers: headers).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
