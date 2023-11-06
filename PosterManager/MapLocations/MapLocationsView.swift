//
//  MapLocationsView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-26.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta && lhs.longitudeDelta == rhs.longitudeDelta
    }
}
extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center && lhs.span == rhs.span
    }
}

struct MapLocationsView: View {
    @EnvironmentObject private var dataModel: DataModel
    @ObservedObject private var viewModel: MapLocationsViewModel
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: MapLocationsViewModel.mapCenterLatitude,
            longitude: MapLocationsViewModel.mapCenterLongitude),
        span: MKCoordinateSpan(
            latitudeDelta: MapLocationsViewModel.mapDefaultRegionSpanDelta,
            longitudeDelta: MapLocationsViewModel.mapDefaultRegionSpanDelta)
    )
    @State var locationsWithinMapRect: [Location] = []
    
    init(viewModel: MapLocationsViewModel = MapLocationsViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region,
                annotationItems: dataModel.locations
            ) { location in
                MapAnnotation(coordinate: viewModel.coordinateForItem(location: location)) {
                    NavigationLink {
                        LocationDetailsView(location: location)
                    } label: {
                        CustomMapMarker(location: location)
                    }
                }
            }
            .ignoresSafeArea(edges: [.top, .trailing, .leading])
            .onAppear() {
                // TODO: continue work on loading only visible locations from Core Data
                //updateLocationsWithinMapRect()
            }
        }
    }
    
    private func updateLocationsWithinMapRect() {
        locationsWithinMapRect = dataModel.locations.filter({ (location: Location) -> Bool in
            let latInDeg = CLLocationDegrees(location.coordinates.latitude)
            let lngInDeg = CLLocationDegrees(location.coordinates.longitude)
            let coord = CLLocationCoordinate2D(latitude: latInDeg, longitude: lngInDeg)
            return isCoordinateInMapRegion(coord: coord)
        })
        print("Locations within rect: \(locationsWithinMapRect)")
    }
    
    private func isCoordinateInMapRegion(coord: CLLocationCoordinate2D) -> Bool {
        let center: CLLocationCoordinate2D = region.center;
        let northWestCorner = CLLocationCoordinate2D(latitude: center.latitude - (region.span.latitudeDelta / 2.0), longitude: center.longitude - (region.span.longitudeDelta / 2.0))
        let southEastCorner = CLLocationCoordinate2D(latitude: center.latitude + (region.span.latitudeDelta / 2.0), longitude: center.longitude + (region.span.longitudeDelta / 2.0))
        return coord.latitude >= northWestCorner.latitude &&
               coord.latitude <= southEastCorner.latitude &&
               coord.longitude >= northWestCorner.longitude &&
               coord.longitude <= southEastCorner.longitude
    }
}

#Preview {
    MapLocationsView()
}
