//
//  ContentView.swift
//  swift-os26
//
//  Created by Jan Senderek on 9/22/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ControlsListView()
                    .navigationTitle("Controls")
            }
            .tabItem {
                Label("Controls", systemImage: "slider.horizontal.3")
            }

            NavigationStack {
                SelectionPickersListView()
                    .navigationTitle("Selection & Pickers")
            }
            .tabItem {
                Label("Selection", systemImage: "checkmark.circle")
            }

            NavigationStack {
                MenusToolbarsListView()
                    .navigationTitle("Menus & Toolbars")
            }
            .tabItem {
                Label("Menus", systemImage: "ellipsis.circle")
            }

            NavigationStack {
                ListsGridsListView()
                    .navigationTitle("Lists & Grids")
            }
            .tabItem {
                Label("Lists", systemImage: "list.bullet")
            }

            NavigationStack {
                NavigationTabsListView()
                    .navigationTitle("Navigation & Tabs")
            }
            .tabItem {
                Label("Nav & Tabs", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                PresentationListView()
                    .navigationTitle("Presentation")
            }
            .tabItem {
                Label("Presentation", systemImage: "rectangle.stack")
            }

            NavigationStack {
                MediaListView()
                    .navigationTitle("Media")
            }
            .tabItem {
                Label("Media", systemImage: "photo")
            }

            NavigationStack {
                LayoutEffectsListView()
                    .navigationTitle("Layout & Effects")
            }
            .tabItem {
                Label("Layout", systemImage: "sparkles")
            }
        }
    }
}

#Preview {
    ContentView()
}
