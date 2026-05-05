import SwiftUI

struct NativeStatusDemoView: View {
    @State private var progress: Double = 0.35
    @State private var score: Double = 0.72

    var body: some View {
        List {
            Section("ProgressView") {
                ProgressView("Indeterminate")

                ProgressView(value: progress) {
                    Text("Determinate")
                } currentValueLabel: {
                    Text("\(Int(progress * 100))%")
                }

                Slider(value: $progress, in: 0...1)
            }

            Section("Gauge") {
                Gauge(value: score) {
                    Text("Readiness")
                } currentValueLabel: {
                    Text("\(Int(score * 100))")
                }
                .gaugeStyle(.accessoryCircular)

                Gauge(value: score) {
                    Text("Capacity")
                }
                .gaugeStyle(.accessoryLinearCapacity)

                Slider(value: $score, in: 0...1)
            }

            Section("ContentUnavailableView") {
                ContentUnavailableView("No Results", systemImage: "magnifyingglass", description: Text("Try changing your search or clearing filters."))
                    .frame(minHeight: 160)

                ContentUnavailableView {
                    Label("Offline", systemImage: "wifi.slash")
                } description: {
                    Text("Show a native empty, error, or unavailable state without building a custom placeholder every time.")
                } actions: {
                    Button("Retry") { }
                        .buttonStyle(.borderedProminent)
                }
                .frame(minHeight: 180)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

