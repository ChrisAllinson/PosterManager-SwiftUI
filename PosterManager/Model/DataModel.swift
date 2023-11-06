//
//  DataModel.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-03.
//

import Foundation
import Combine

final class DataModel: ObservableObject {
    
    // MARK: published properties
    
    @Published var locations: [Location] = DataModel.decodeFromJsonFile(named: "locations.json")
    
    // MARK: static methods
    
    static func decodeFromJsonFile<T: Decodable>(named filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            ErrorManager.shared.showAlert(errorMessage: "Couldn't find \(filename) in main bundle.")
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            ErrorManager.shared.showAlert(errorMessage: "Couldn't load \(filename) from main bundle:\n\(error)")
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            ErrorManager.shared.showAlert(errorMessage: "Couldn't parse \(filename) as \(T.self):\n\(error)")
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
