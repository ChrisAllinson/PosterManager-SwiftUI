//
//  PosterManagerApp.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-26.
//

import SwiftUI

@main
struct PosterManagerApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataModel)
        }
    }
}
