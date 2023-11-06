//
//  ViewPosterViewModel.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-08.
//

import Foundation
import SwiftUI

final class ViewPosterViewModel: ObservableObject {
    
    // MARK: instance properties
    
    var poster: Poster
    
    // MARK: published properties
    
    @Published var image: Image? = nil
    
    // MARK: lifecycle methods
    
    required init(poster: Poster) {
        self.poster = poster
    }
    
    // MARK: helpers
    
    let viewPosterFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter
    }()
    
    // MARK: public methods
    
    func loadImageFromPosterImageData() {
        guard let posterImageData = poster.image else {
            return
        }
        guard let uiImage = UIImage(data: posterImageData) else {
            return
        }
        
        self.image = Image(uiImage: uiImage)
    }
}
