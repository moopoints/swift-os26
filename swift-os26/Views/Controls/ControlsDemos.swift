import SwiftUI

struct ButtonsDemoView: View {
    @State private var tappedCount: Int = 0

    var body: some View {
        List {
            Section("Native Buttons – Text Only") {
                HStack(spacing: 12) {
                    Button("Default") { handleTap() }
                        .lineLimit(1)
                        .buttonStyle(.automatic)
                    Button("Bordered") { handleTap() }
                        .lineLimit(1)
                        .buttonStyle(.bordered)
                    Button("Prominent") { handleTap() }
                        .lineLimit(1)
                        .buttonStyle(.borderedProminent)
                }
            }

            Section("Native Buttons – Icon Only") {
                HStack(spacing: 12) {
                    Button(action: handleTap) { Label("Default", systemImage: "heart.fill").labelStyle(.iconOnly) }
                        .buttonStyle(.automatic)
                    Button(action: handleTap) { Label("Bordered", systemImage: "heart.fill").labelStyle(.iconOnly) }
                        .buttonStyle(.bordered)
                    Button(action: handleTap) { Label("Prominent", systemImage: "heart.fill").labelStyle(.iconOnly) }
                        .buttonStyle(.borderedProminent)
                }
            }

            Section("Roles & Sizes") {
                HStack(spacing: 12) {
                    Button(role: .cancel, action: handleTap) { Label("Cancel", systemImage: "xmark.circle").lineLimit(1) }
                    Button(role: .destructive, action: handleTap) { Label("Delete", systemImage: "trash").lineLimit(1) }
                }

                HStack(spacing: 12) {
                    Button("Mini") { handleTap() }
                        .lineLimit(1)
                        .controlSize(.mini)
                        .buttonStyle(.bordered)
                    Button("Small") { handleTap() }
                        .lineLimit(1)
                        .controlSize(.small)
                        .buttonStyle(.bordered)
                }
                HStack(spacing: 12) {
                    Button("Regular") { handleTap() }
                        .lineLimit(1)
                        .controlSize(.regular)
                        .buttonStyle(.bordered)
                    Button("Large") { handleTap() }
                        .lineLimit(1)
                        .controlSize(.large)
                        .buttonStyle(.bordered)
                }
            }

            Section("Plain & Link") {
                Button("Plain Button") { tappedCount += 1 }
                    .buttonStyle(.plain)

                Link("Apple Developer", destination: URL(string: "https://developer.apple.com")!)
            }

            Section("Rounded & Capsule Shape") {
                HStack(spacing: 12) {
                    Button("Rounded") { tappedCount += 1 }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 10))

                    Button("Capsule") { tappedCount += 1 }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                }
            }

            Section("Glass Buttons (Native)") {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Mini")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.mini)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Small")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.small)
                            .buttonStyle(GlassButtonStyle())
                    }
                    HStack(spacing: 12) {
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Regular")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.regular)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Large")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.large)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) {
                            Image(systemName: "bolt.fill")
                        }
                        .buttonBorderShape(.circle)
                        .controlSize(.large)
                        .buttonStyle(GlassButtonStyle())
                    }
                    HStack(spacing: 12) {
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.mini)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.small)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.regular)
                            .buttonStyle(GlassButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.large)
                            .buttonStyle(GlassButtonStyle())
                    }
                }
            }

            Section("Glass Prominent Buttons (Native)") {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 12) {
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Mini")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.mini)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Small")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.small)
                            .buttonStyle(GlassProminentButtonStyle())
                    }
                    HStack(spacing: 12) {
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Regular")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.regular)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) {
                            HStack(spacing: 6) {
                                Image(systemName: "bolt.fill")
                                Text("Large")
                                    .lineLimit(1)
                            }
                        }
                            .controlSize(.large)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) {
                            Image(systemName: "bolt.fill")
                        }
                        .buttonBorderShape(.circle)
                        .controlSize(.large)
                        .buttonStyle(GlassProminentButtonStyle())
                    }
                    HStack(spacing: 12) {
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.mini)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.small)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.regular)
                            .buttonStyle(GlassProminentButtonStyle())
                        Button(action: handleTap) { Image(systemName: "bolt.fill") }
                            .buttonBorderShape(.circle)
                            .controlSize(.large)
                            .buttonStyle(GlassProminentButtonStyle())
                    }
                }
            }

            // Removed custom glass styles to keep only native elements

            Section("Tap Count") {
                Text("Tapped: \(tappedCount)")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(.systemGray6))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func handleTap() {
        tappedCount += 1
    }
}

struct TogglesDemoView: View {
    @State private var isOn: Bool = true
    @State private var isWiFiOn: Bool = false

    var body: some View {
        List {
            Section("Basic Toggle") {
                Toggle(isOn: $isOn) {
                    Text("Enabled")
                }
            }

            Section("With Icons") {
                Toggle(isOn: $isWiFiOn) {
                    Label("Wi‑Fi", systemImage: isWiFiOn ? "wifi" : "wifi.slash")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SegmentedControlsDemoView: View {
    enum Segment: String, CaseIterable, Identifiable {
        case first = "First"
        case second = "Second"
        case third = "Third"
        var id: String { rawValue }
    }

    @State private var selection: Segment = .first

    var body: some View {
        List {
            Section("Picker .segmented") {
                Picker("Segment", selection: $selection) {
                    ForEach(Segment.allCases) { seg in
                        Text(seg.rawValue).tag(seg)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section("Selection") {
                Text("Selected: \(selection.rawValue)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SlidersDemoView: View {
    @State private var value: Double = 0.5
    @State private var speed: Double = 30

    var body: some View {
        List {
            Section("Basic Slider") {
                Slider(value: $value)
                Text("Value: \(value, specifier: "%.2f")")
            }

            Section("Ranged Slider with Step") {
                Slider(value: $speed, in: 0...120, step: 5) {
                    Text("Speed")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("120")
                }
                Text("Speed: \(Int(speed)) km/h")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SteppersDemoView: View {
    @State private var quantity: Int = 1
    @State private var level: Int = 5

    var body: some View {
        List {
            Section("Basic Stepper") {
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                }
            }

            Section("With onIncrement/onDecrement") {
                Stepper("Level: \(level)", onIncrement: {
                    level = min(level + 1, 10)
                }, onDecrement: {
                    level = max(level - 1, 0)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}




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
