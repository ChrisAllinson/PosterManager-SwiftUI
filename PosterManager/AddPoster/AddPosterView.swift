//
//  AddPosterView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-05.
//

import SwiftUI
import PhotosUI

struct AddPosterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel: AddPosterViewModel
    
    init(location: Location, viewModel: AddPosterViewModel? = nil) {
        if let viewModel = viewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = AddPosterViewModel(location: location)
        }
    }
    
    var body: some View {
        ScrollView {
            Text("Select_a_photo")
                .padding(EdgeInsets(top: 20.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
            PhotosPicker(selection: $viewModel.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                Image(systemName: "pencil.circle.fill")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 30))
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(.borderless)
            
            Text("Photo_preview")
                .padding(EdgeInsets(top: 30.0, leading: 0.0, bottom: 10.0, trailing: 0.0))
            viewModel.posterImage?.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
                .border(.black, width: 1)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem {
                Button {
                    addPhoto()
                } label: {
                    Text("Save")
                }
            }
        }
        .navigationTitle(Text(NSLocalizedString(AddPosterViewModel.navigationTitle, comment: "")))
    }
    
    private func addPhoto() {
        withAnimation {
            let newPoster = Poster(context: viewContext)
            newPoster.locationID = Int16(viewModel.location.id)
            newPoster.timestamp = Date()
            newPoster.image = viewModel.posterImage?.data ?? nil

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                ErrorManager.shared.showAlert(errorMessage: "Unresolved error \(nsError), \(nsError.userInfo)")
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    let previewLocation = PreviewManager.shared.previewLocation
    return AddPosterView(location: previewLocation, viewModel: AddPosterViewModel(location: previewLocation))
}
