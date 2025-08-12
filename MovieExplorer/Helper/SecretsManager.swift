//
//  SecretsManager.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import Foundation

class SecretsManager {
    static let shared = SecretsManager()
    
    let tmdbReadAccessToken: String
    
    private init() {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            fatalError("Could not find Secrets.plist file.")
        }
        
        guard let token = dict["tmdb_read_access_token"] as? String else {
            fatalError("Could not find 'tmdb_read_access_token' in Secrets.plist.")
        }
        
        self.tmdbReadAccessToken = token
    }
}
