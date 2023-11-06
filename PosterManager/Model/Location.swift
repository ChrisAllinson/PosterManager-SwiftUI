//
//  Location.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-03.
//

import Foundation

struct Location: Identifiable, Codable {
    var id: Int
    var name: String
    var category: String
    var city: String
    var province: String
    var isFeatured: Bool
    var isFavorite: Bool
    var coordinates: Coordinates
    var description: String
    var imageName: String
}

struct Coordinates: Codable {
    var latitude: Float
    var longitude: Float
}
