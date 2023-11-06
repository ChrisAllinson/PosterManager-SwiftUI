//
//  LocationDetailsViewModel.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-05.
//

import Foundation
import SwiftUI
import PhotosUI

final class LocationDetailsViewModel: ObservableObject {
    
    // MARK: constants
    
    static let predicate = "locationID = %i"
    
    // MARK: instance properties
    
    let location: Location
    
    // MARK: lifecycle methods
    
    required init(location: Location) {
        self.location = location
    }
    
    // MARK: helpers
    
    let navigationTitleText: Text = {
        //Text(NSLocalizedString("Select_a_photo", comment: ""))
        Text("Select_a_photo", comment: "")
    }()
    
    let posterRowFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    // MARK: public methods
    
    func navigationLinkLabel(poster: Poster) -> Text {
        guard let timestamp = poster.timestamp else {
            return Text("Unknown_date_time")
        }
        
        return Text(timestamp, formatter: posterRowFormatter)
    }
}
