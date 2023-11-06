//
//  AddPosterViewModel.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-10-05.
//

import Foundation
import SwiftUI
import PhotosUI

final class AddPosterViewModel: ObservableObject {
    
    // MARK: enums
    
    enum TransferError: Error {
        case importFailed
    }
    
    // MARK: structs
    
    struct PosterImage: Transferable {
        let image: Image
        let data: Data
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
            #if canImport(AppKit)
                guard let nsImage = NSImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
                return PosterImage(image: image, data: data)
            #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return PosterImage(image: image, data: data)
            #else
                throw TransferError.importFailed
            #endif
            }
        }
    }
    
    // MARK: constants
    
    static let navigationTitle = "Add_new_photo"
    
    // MARK: instance properties
    
    let location: Location
    
    // MARK: published properties
    
    @Published var posterImage: PosterImage?
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                //imageState = .loading(progress)
            } else {
                //imageState = .empty
            }
        }
    }
    
    // MARK: lifecycle methods
    
    required init(location: Location) {
        self.location = location
    }
    
    // MARK: private methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PosterImage.self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    //self.imageState = .success(profileImage.image)
                    self.posterImage = profileImage
                    print("Success - With image")
                case .success(nil):
                    //self.imageState = .empty
                    self.posterImage = nil
                    print("Success - No image")
                case .failure(let error):
                    //self.imageState = .failure(error)
                    self.posterImage = nil
                    print("Error - \(error.localizedDescription)")
                }
            }
        }
    }
}
