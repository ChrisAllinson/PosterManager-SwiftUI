//
//  ListLocationsView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-26.
//

import SwiftUI

struct ListLocationsView: View {
    @EnvironmentObject private var dataModel: DataModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataModel.locations) { location in
                    NavigationLink {
                        LocationDetailsView(location: location)
                    } label: {
                        Text("\(location.name)")
                    }
                }
            }
            .padding(EdgeInsets(top: 20.0, leading: 0.0, bottom: 20.0, trailing: 0.0))
            .navigationTitle("Select_a_location")
        }
    }
}

struct ListLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        ListLocationsView()
    }
}
