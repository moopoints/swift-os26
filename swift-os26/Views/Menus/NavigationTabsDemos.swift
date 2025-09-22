import SwiftUI

struct NavigationStackDemoView: View {
    var body: some View {
        List(0..<10) { i in
            NavigationLink("Detail #\(i)") { Text("Detail #\(i)") }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NavigationSplitViewDemo: View {
    @State private var selection: Int? = nil
    var body: some View {
        NavigationSplitView {
            List(0..<20, selection: $selection) { i in
                Text("Row #\(i)")
            }
            .navigationTitle("Master")
        } detail: {
            if let selectionUnwrapped: Int = selection {
                Text("Detail #\(selectionUnwrapped)")
            } else {
                Text("Select a row")
            }
        }
    }
}

struct TabViewStylesDemoView: View {
    var body: some View {
        TabView {
            Text("First").tabItem { Label("One", systemImage: "1.circle") }
            Text("Second").tabItem { Label("Two", systemImage: "2.circle") }
        }
        .tabViewStyle(.automatic)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FloatingSearchOverlayDemoView: View {
    @State private var text: String = ""
    var body: some View {
        List(0..<30) { i in
            Text("Row #\(i)")
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .padding()
                    .background(.thinMaterial, in: Circle())
            }
            .padding()
            .shadow(radius: 4)
        }
        .searchable(text: $text)
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - iOS 26 style Tab Bar with floating Search tab
struct TabViewWithSearchRoleDemoView: View {
    @State private var search: String = ""

    var body: some View {
        TabView {
            Tab("One", systemImage: "1.circle") {
                Text("One")
            }
            Tab("Two", systemImage: "2.circle") {
                Text("Two")
            }
            Tab("Search", systemImage: "3.circle", role: .search) {
                NavigationStack {
                    Text("Search")
                }
            }
        }
        .searchable(text: $search)
        .navigationBarTitleDisplayMode(.inline)
    }
}


