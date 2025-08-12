//
//  MovieExplorerApp.swift
//  MovieExplorer
//
//  Created by Arya Maadeni on 12/08/25.
//

import SwiftUI
import SwiftData

@main
struct MovieExplorerApp: App {
    init() {
        UISearchBar.appearance().tintColor = UIColor(Color.appPrimary)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .defaultTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
            .attributedPlaceholder = NSAttributedString(
                string: "Search",
                attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.6)]
            )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(Color.appPrimary)
        }
        .modelContainer(for: Movie.self)
    }
}
