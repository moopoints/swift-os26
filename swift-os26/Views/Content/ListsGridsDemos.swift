import SwiftUI

struct ListStylesDemoView: View {
    var body: some View {
        List {
            Section("Plain") {
                ForEach(1...5, id: \.self) { i in Text("Item \(i)") }
            }
            .listStyle(.plain)

            Section("Inset") {
                ForEach(6...10, id: \.self) { i in Text("Item \(i)") }
            }
            .listStyle(.inset)

            Section("Grouped") {
                ForEach(11...15, id: \.self) { i in Text("Item \(i)") }
            }
            .listStyle(.insetGrouped)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwipeActionsDemoView: View {
    @State private var items: [String] = (1...10).map { "Row \($0)" }

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) { } label: { Label("Delete", systemImage: "trash") }
                        Button { } label: { Label("Flag", systemImage: "flag") }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button { } label: { Label("Pin", systemImage: "pin") }
                    }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReorderingDemoView: View {
    @State private var items: [String] = (1...10).map { "Item \($0)" }

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item)
            }
            .onMove { indices, newOffset in
                items.move(fromOffsets: indices, toOffset: newOffset)
            }
        }
        .toolbar { EditButton() }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DisclosureOutlineDemoView: View {
    struct Node: Identifiable {
        let id: UUID = UUID()
        let name: String
        var children: [Node]? = nil
    }

    private let data: [Node] = [
        Node(name: "Fruits", children: [Node(name: "Apple"), Node(name: "Banana")]),
        Node(name: "Vegetables", children: [Node(name: "Carrot"), Node(name: "Broccoli")])
    ]

    var body: some View {
        List(data, children: \.children) { node in
            Text(node.name)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GridsDemoView: View {
    private let columns: [GridItem] = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(0..<30) { index in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(index % 2 == 0 ? .blue.opacity(0.2) : .green.opacity(0.2))
                        .frame(height: 80)
                        .overlay(Text("#\(index)") )
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


