//
//  PreviewManager.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-19.
//

import Foundation

struct PreviewManager {
    
    // MARK: singleton instance properties
    
    static let shared = PreviewManager()
    
    // MARK: lifecycle methods
    
    private init() { /*...*/ }
    
    // MARK: helpers
    
    let previewLocation = {
        Location(id: 0, name: "", category: "", city: "", province: "", isFeatured: false, isFavorite: false, coordinates: Coordinates(latitude: 0.0, longitude: 0.0), description: "", imageName: "")
    }()
    
    let previewPoster = {
        Poster()
    }()
}
