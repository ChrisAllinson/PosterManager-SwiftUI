//
//  ViewPosterView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-08.
//

import SwiftUI

struct ViewPosterView: View {
    @ObservedObject var viewModel: ViewPosterViewModel
    
    init(poster: Poster, viewModel: ViewPosterViewModel? = nil) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = ViewPosterViewModel(poster: poster)
        }
    }
    
    var body: some View {
        ScrollView {
            Text("\(viewModel.poster.timestamp!, formatter: viewModel.viewPosterFormatter)")
                .padding(EdgeInsets(top: 10.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
            viewModel.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
                .border(.black, width: 1)
            
            Spacer()
        }
        .task {
            await loadImage()
        }
    }
    
    func loadImage() async {
        viewModel.loadImageFromPosterImageData()
    }
}

#Preview {
    let previewPoster = PreviewManager.shared.previewPoster
    return ViewPosterView(poster: previewPoster)
}
