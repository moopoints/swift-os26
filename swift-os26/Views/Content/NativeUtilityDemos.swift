import SwiftUI

struct NativeUtilityDemoView: View {
    @State private var pastedText: String = ""
    @State private var isGrouped: Bool = true
    @State private var count: Int = 0

    var body: some View {
        List {
            Section("ShareLink") {
                ShareLink(item: URL(string: "https://developer.apple.com/xcode/swiftui/")!) {
                    Label("Share SwiftUI Docs", systemImage: "square.and.arrow.up")
                }
            }

            Section("PasteButton") {
                PasteButton(payloadType: String.self) { strings in
                    pastedText = strings.joined(separator: "\n")
                }
                .buttonBorderShape(.roundedRectangle(radius: 10))

                if pastedText.isEmpty {
                    Text("Paste text from the clipboard.")
                        .foregroundStyle(.secondary)
                } else {
                    Text(pastedText)
                }
            }

            Section("ControlGroup") {
                ControlGroup {
                    Button { count = max(0, count - 1) } label: {
                        Label("Decrease", systemImage: "minus")
                    }
                    Button { count += 1 } label: {
                        Label("Increase", systemImage: "plus")
                    }
                    Button { count = 0 } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                    }
                }

                LabeledContent("Count", value: "\(count)")
            }

            Section("Grouped Toggle") {
                Toggle("Use grouped layout", isOn: $isGrouped)
                LabeledContent("Mode", value: isGrouped ? "Grouped" : "Plain")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

