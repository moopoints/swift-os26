import SwiftUI

struct ButtonsDemoView: View {
    @State private var tappedCount: Int = 0

    var body: some View {
        List {
            Section("Prominent & Bordered") {
                // Text-only
                HStack(spacing: 12) {
                    Button("Default") { tappedCount += 1 }
                        .lineLimit(1)
                        .buttonStyle(.automatic)

                    Button("Bordered") { tappedCount += 1 }
                        .lineLimit(1)
                        .buttonStyle(.bordered)
                }
                HStack(spacing: 12) {
                    Button("Prominent") { tappedCount += 1 }
                        .lineLimit(1)
                        .buttonStyle(.borderedProminent)
                }

                // Text + icon (use monochrome symbols so they match label color)
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Default", systemImage: "star")
                            .symbolRenderingMode(.monochrome)
                            .lineLimit(1)
                    }
                    .buttonStyle(.automatic)

                    Button { tappedCount += 1 } label: {
                        Label("Bordered", systemImage: "star.fill")
                            .symbolRenderingMode(.monochrome)
                            .lineLimit(1)
                    }
                    .buttonStyle(.bordered)
                }
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Prominent", systemImage: "bolt.fill")
                            .symbolRenderingMode(.monochrome)
                            .lineLimit(1)
                    }
                    .buttonStyle(.borderedProminent)
                }

                // Icon-only
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Default", systemImage: "heart.fill").labelStyle(.iconOnly)
                    }
                    .buttonStyle(.automatic)

                    Button { tappedCount += 1 } label: {
                        Label("Bordered", systemImage: "heart.fill").labelStyle(.iconOnly)
                    }
                    .buttonStyle(.bordered)
                }
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Prominent", systemImage: "heart.fill").labelStyle(.iconOnly)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            Section("Roles & Sizes") {
                HStack(spacing: 12) {
                    Button(role: .cancel) {
                        tappedCount += 1
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle")
                    }

                    Button(role: .destructive) {
                        tappedCount += 1
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }

                HStack(spacing: 12) {
                    Button("Mini") { tappedCount += 1 }
                        .lineLimit(1)
                        .controlSize(.mini)
                        .buttonStyle(.bordered)
                    Button("Small") { tappedCount += 1 }
                        .lineLimit(1)
                        .controlSize(.small)
                        .buttonStyle(.bordered)
                }
                HStack(spacing: 12) {
                    Button("Regular") { tappedCount += 1 }
                        .lineLimit(1)
                        .controlSize(.regular)
                        .buttonStyle(.bordered)
                    Button("Large") { tappedCount += 1 }
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

            Section("Glass Buttons – Capsule") {
                // Text + icon, split into two rows to avoid wrapping
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Mini", systemImage: "bolt.fill").symbolRenderingMode(.monochrome).lineLimit(1)
                    }
                    .controlSize(.mini)
                    .buttonStyle(GlassButtonStyle())

                    Button { tappedCount += 1 } label: {
                        Label("Small", systemImage: "bolt.fill").symbolRenderingMode(.monochrome).lineLimit(1)
                    }
                    .controlSize(.small)
                    .buttonStyle(GlassButtonStyle())
                }
                HStack(spacing: 12) {
                    Button { tappedCount += 1 } label: {
                        Label("Regular", systemImage: "bolt.fill").symbolRenderingMode(.monochrome).lineLimit(1)
                    }
                    .controlSize(.regular)
                    .buttonStyle(GlassButtonStyle())

                    Button { tappedCount += 1 } label: {
                        Label("Large", systemImage: "bolt.fill").symbolRenderingMode(.monochrome).lineLimit(1)
                    }
                    .controlSize(.large)
                    .buttonStyle(GlassButtonStyle())
                }
            }

            Section("Glass Buttons – Circle (Icon Only)") {
                HStack(spacing: 14) {
                    Button { tappedCount += 1 } label: { Image(systemName: "bolt.fill").symbolRenderingMode(.monochrome) }
                        .buttonBorderShape(.circle)
                        .controlSize(.mini)
                        .buttonStyle(GlassButtonStyle())

                    Button { tappedCount += 1 } label: { Image(systemName: "bolt.fill").symbolRenderingMode(.monochrome) }
                        .buttonBorderShape(.circle)
                        .controlSize(.small)
                        .buttonStyle(GlassButtonStyle())

                    Button { tappedCount += 1 } label: { Image(systemName: "bolt.fill").symbolRenderingMode(.monochrome) }
                        .buttonBorderShape(.circle)
                        .controlSize(.regular)
                        .buttonStyle(GlassButtonStyle())

                    Button { tappedCount += 1 } label: { Image(systemName: "bolt.fill").symbolRenderingMode(.monochrome) }
                        .buttonBorderShape(.circle)
                        .controlSize(.large)
                        .buttonStyle(GlassButtonStyle())
                }
            }

            Section("Tap Count") {
                Text("Tapped: \(tappedCount)")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(.systemGray6))
        .navigationBarTitleDisplayMode(.inline)
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


// MARK: - Glass Button Style

struct GlassButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.controlSize) private var controlSize: ControlSize

    func makeBody(configuration: Configuration) -> some View {
        let opacity: Double = isEnabled ? (configuration.isPressed ? 0.65 : 0.88) : 0.4
        let strokeOpacity: Double = isEnabled ? 0.28 : 0.18

        let paddingV: CGFloat
        let paddingH: CGFloat
        let cornerRadius: CGFloat
        let square: CGFloat

        switch controlSize {
        case .mini:
            paddingV = 6; paddingH = 10; cornerRadius = 12; square = 28
        case .small:
            paddingV = 7; paddingH = 12; cornerRadius = 14; square = 34
        case .regular:
            paddingV = 9; paddingH = 14; cornerRadius = 16; square = 42
        case .large:
            paddingV = 12; paddingH = 18; cornerRadius = 18; square = 52
        @unknown default:
            paddingV = 9; paddingH = 14; cornerRadius = 16; square = 42
        }

        return configuration.label
            .font(.body)
            .foregroundStyle(.primary)
            .padding(.vertical, paddingV)
            .padding(.horizontal, paddingH)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .opacity(opacity)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(strokeOpacity), lineWidth: 1)
            )
            .shadow(color: .black.opacity(configuration.isPressed ? 0.05 : 0.12), radius: configuration.isPressed ? 2 : 6, x: 0, y: configuration.isPressed ? 1 : 3)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
            .frame(minWidth: 0)
            .contentShape(Rectangle())
    }
}


