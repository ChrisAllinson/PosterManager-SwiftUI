//
//  ContentView.swift
//  PosterManager
//
//  Created by Chris Allinson on 2023-09-26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private enum Tab {
        case list
        case map
    }
    
    @State private var selection: Tab = .list
    
    var body: some View {
        TabView(selection: $selection) {
            ListLocationsView()
                .tabItem {
                    Label("List_locations", systemImage: "star")
                }
                .tag(Tab.list)
                .badge(0)
            
            MapLocationsView()
                .tabItem {
                    Label("Map_locations", systemImage: "list.bullet")
                }
                .tag(Tab.map)
                .badge(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
