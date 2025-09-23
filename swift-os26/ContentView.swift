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
                ControlsTabView()
                    .navigationTitle("Controls")
            }
            .tabItem {
                Label("Controls", systemImage: "slider.horizontal.3")
            }

            NavigationStack {
                NavsTabView()
                    .navigationTitle("Navs & Menus")
            }
            .tabItem {
                Label("Navs & Menus", systemImage: "ellipsis.circle")
            }

            NavigationStack {
                ContentTabView()
                    .navigationTitle("Content")
            }
            .tabItem {
                Label("Content", systemImage: "doc.text.image")
            }
        }
    }
}

#Preview {
    ContentView()
}
