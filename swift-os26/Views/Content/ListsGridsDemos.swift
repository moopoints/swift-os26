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

struct DisclosureGroupDemoView: View {
    @State private var showRendering: Bool = true
    @State private var showInput: Bool = false
    @State private var showAdvanced: Bool = false

    var body: some View {
        List {
            DisclosureGroup("Rendering", isExpanded: $showRendering) {
                LabeledContent("Frame rate", value: "120 Hz")
                LabeledContent("Color mode", value: "Wide gamut")
                Toggle("Show debug overlay", isOn: .constant(false))
            }

            DisclosureGroup("Input", isExpanded: $showInput) {
                Toggle("Haptics", isOn: .constant(true))
                Toggle("Keyboard shortcuts", isOn: .constant(true))
            }

            DisclosureGroup("Advanced", isExpanded: $showAdvanced) {
                Text("Standalone DisclosureGroup works well for settings, inspectors, and progressive disclosure inside forms.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FormsRowsDemoView: View {
    enum Theme: String, CaseIterable, Identifiable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"

        var id: String { rawValue }
    }

    @State private var theme: Theme = .system
    @State private var isLivePreviewEnabled: Bool = true
    @State private var intensity: Double = 0.65
    @State private var notes: String = ""

    var body: some View {
        Form {
            Section("LabeledContent") {
                LabeledContent("Build", value: "Swift OS 26")
                LabeledContent {
                    Text("Ready")
                        .foregroundStyle(.green)
                } label: {
                    Label("Status", systemImage: "checkmark.seal")
                }
            }

            Section("Settings Rows") {
                Picker("Theme", selection: $theme) {
                    ForEach(Theme.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }

                Toggle("Live preview", isOn: $isLivePreviewEnabled)

                LabeledContent("Intensity") {
                    Slider(value: $intensity)
                        .frame(maxWidth: 180)
                }
            }

            Section("ControlGroup") {
                ControlGroup {
                    Button { notes.append("B") } label: { Image(systemName: "bold") }
                    Button { notes.append("I") } label: { Image(systemName: "italic") }
                    Button { notes.append("U") } label: { Image(systemName: "underline") }
                }
                .controlGroupStyle(.automatic)
            }

            Section("Notes") {
                TextField("Inline note", text: $notes, axis: .vertical)
                    .lineLimit(2...4)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ScrollUXDemoView: View {
    @State private var items: [Int] = Array(1...30)
    @State private var latestRefresh: Date? = nil

    var body: some View {
        ScrollViewReader { proxy in
            List {
                Section {
                    Button("Scroll to bottom") {
                        withAnimation(.snappy) {
                            proxy.scrollTo(items.last, anchor: .bottom)
                        }
                    }
                    Button("Scroll to top") {
                        withAnimation(.snappy) {
                            proxy.scrollTo(items.first, anchor: .top)
                        }
                    }
                    if let latestRefresh {
                        Text("Refreshed \(latestRefresh.formatted(date: .omitted, time: .standard))")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Rows") {
                    ForEach(items, id: \.self) { item in
                        HStack {
                            Image(systemName: "arrow.down.circle")
                                .foregroundStyle(.blue)
                            Text("Scrollable row \(item)")
                            Spacer()
                        }
                        .id(item)
                    }
                }
            }
            .refreshable {
                latestRefresh = Date()
                items.shuffle()
            }
            .contentMargins(.top, 8, for: .scrollContent)
            .scrollIndicators(.visible)
        }
        .safeAreaInset(edge: .bottom) {
            Text("safeAreaInset keeps actions visible above the home indicator.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(.thinMaterial)
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

