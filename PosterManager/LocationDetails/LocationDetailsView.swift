//
//  LocationDetailsView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-28.
//

import SwiftUI
import PhotosUI
import CoreData

struct LocationDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var fetchRequest: FetchedResults<Poster>
    @ObservedObject private var viewModel: LocationDetailsViewModel
    @State var showAlert = true
    @State var errorAlertTitle = "Error"
    @State var errorAlertMessage = "Unknown_error"
    
    init(location: Location, viewModel: LocationDetailsViewModel? = nil) {
        _fetchRequest = FetchRequest<Poster>(sortDescriptors: [], predicate: NSPredicate(format: LocationDetailsViewModel.predicate, location.id))
        if let viewModel = viewModel {
            self.viewModel = viewModel
        } else {
            self.viewModel = LocationDetailsViewModel(location: location)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.location.name)
                HStack {
                    Text("\(viewModel.location.coordinates.latitude)")
                    Text("\(viewModel.location.coordinates.longitude)")
                }
            }
            
            List {
                ForEach(fetchRequest) { poster in
                    NavigationLink {
                        ViewPosterView(poster: poster)
                    } label: {
                        viewModel.navigationLinkLabel(poster: poster)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 20.0, trailing: 0.0))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink {
                        AddPosterView(location: viewModel.location)
                    } label: {
                        Text("+")
                    }
                }
            }
        }
        .navigationTitle(viewModel.navigationTitleText)
        //.alert(isPresented: $showAlert) {
        //    Alert(title: Text(errorAlertTitle), message: Text(errorAlertMessage))
        //}
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                //errorAlertMessage = "Unresolved error \(nsError), \(nsError.userInfo)"
                //showAlert = true
                
                ErrorManager.shared.showAlert(errorMessage: "Unresolved error \(nsError), \(nsError.userInfo)")
                //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    let previewLocation = PreviewManager.shared.previewLocation
    return LocationDetailsView(location: previewLocation)
              .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
