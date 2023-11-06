//
//  MapLocationsViewModel.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-27.
//

import SwiftUI
import CoreLocation

final class MapLocationsViewModel: ObservableObject {
    
    // MARK: constants
    
    static let mapCenterLatitude = 53.518084
    static let mapCenterLongitude = -113.497593
    static let mapDefaultRegionSpanDelta = 0.01
    
    // MARK: public methods
    
    func coordinateForItem(location: Location) -> CLLocationCoordinate2D {
        let lat = location.coordinates.latitude
        let lng = location.coordinates.longitude
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))
    }
}
