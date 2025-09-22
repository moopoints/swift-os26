import SwiftUI

struct MenusDemoView: View {
    @State private var selection: String = ""

    var body: some View {
        List {
            Section("Basic Menu") {
                Menu("Actions") {
                    Button("New", systemImage: "plus") { selection = "New" }
                    Button("Duplicate", systemImage: "doc.on.doc") { selection = "Duplicate" }
                    Divider()
                    Button(role: .destructive) {
                        selection = "Delete"
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
                Text("Selected: \(selection)")
            }

            Section("Nested Menu") {
                Menu("Share") {
                    Button("Mail", systemImage: "envelope") { selection = "Mail" }
                    Button("Messages", systemImage: "message") { selection = "Messages" }
                    Menu("More") {
                        Button("Copy Link", systemImage: "link") { selection = "Copy Link" }
                        Button("Save", systemImage: "square.and.arrow.down") { selection = "Save" }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContextMenusDemoView: View {
    @State private var status: String = ""

    var body: some View {
        List {
            Section("Context Menu on Row") {
                Text("Long-press me")
                    .contextMenu {
                        Button("Favorite", systemImage: "star") { status = "Favorited" }
                        Button("Rename", systemImage: "pencil") { status = "Rename" }
                        Button(role: .destructive) {
                            status = "Deleted"
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                Text("Status: \(status)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ToolbarsDemoView: View {
    @State private var isEditing: Bool = false
    @State private var count: Int = 0

    var body: some View {
        List {
            Section("Toolbar Items") {
                Text("Count: \(count)")
                Text(isEditing ? "Mode: Editing" : "Mode: Viewing")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(isEditing ? "Done" : "Edit") { isEditing.toggle() }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") { count += 1 }
            }
            ToolbarItemGroup(placement: .bottomBar) {
                Button("Reset") { count = 0 }
                Spacer()
                Button("More") { }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ToolbarTitleMenuDemoView: View {
    @State private var sortAscending: Bool = true
    @State private var filterFavorites: Bool = false

    var body: some View {
        List {
            ForEach(0..<10) { index in
                HStack {
                    Image(systemName: filterFavorites ? "star.fill" : "star")
                    Text("Item \(index)")
                }
            }
        }
        .toolbarTitleMenu {
            Button(sortAscending ? "Sort Desc" : "Sort Asc", systemImage: "arrow.up.arrow.down") {
                sortAscending.toggle()
            }
            Button(filterFavorites ? "Show All" : "Only Favorites", systemImage: "line.3.horizontal.decrease.circle") {
                filterFavorites.toggle()
            }
        }
        .navigationTitle("Toolbar Menu")
        .navigationBarTitleDisplayMode(.inline)
    }
}


