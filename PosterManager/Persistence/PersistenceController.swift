//
//  Persistence.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-26.
//

import CoreData

class PersistenceController {
    
    // MARK: constants
    
    let persistentContainerName = "PosterManager"
    
    // MARK: singleton instance properties
    
    static let shared = PersistenceController()
    
    // MARK: instance properties
    
    let container: NSPersistentContainer
    
    // MARK: lifecycle methods
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: persistentContainerName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                ErrorManager.shared.showAlert(errorMessage: "Unresolved error \(error), \(error.userInfo)")
                //fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: for preview
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPoster = Poster(context: viewContext)
            newPoster.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            ErrorManager.shared.showAlert(errorMessage: "Unresolved error \(nsError), \(nsError.userInfo)")
            //fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
