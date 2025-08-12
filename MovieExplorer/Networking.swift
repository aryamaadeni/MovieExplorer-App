//
//  Networking.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation

protocol NetworkManaging {
    func fetchData<T: Codable>(from endpoint: NetworkManager.Endpoint) async throws -> T
}
