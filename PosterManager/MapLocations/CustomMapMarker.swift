//
//  CustomMapMarker.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-03.
//

import SwiftUI

struct CustomMapMarker: View {
    let location: Location
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.black)
                .frame(width: 44, height: 44, alignment: .center)
            Circle()
                .foregroundColor(location.isFeatured ? .green : location.isFavorite ? .pink : .orange)
                .frame(width: 42, height: 42, alignment: .center)
        }
    }
}

#Preview {
    let previewLocation = PreviewManager.shared.previewLocation
    return CustomMapMarker(location: previewLocation)
}
