import SwiftUI

struct PickerStylesDemoView: View {
    enum Fruit: String, CaseIterable, Identifiable { case apple = "Apple", banana = "Banana", cherry = "Cherry"; var id: String { rawValue } }
    @State private var selection: Fruit = .apple

    var body: some View {
        List {
            Section("Menu Picker") {
                Picker("Fruit", selection: $selection) {
                    ForEach(Fruit.allCases) { fruit in
                        Text(fruit.rawValue).tag(fruit)
                    }
                }
                .pickerStyle(.menu)
                Text("Selected: \(selection.rawValue)")
            }

            Section("Inline Picker") {
                Picker("Fruit", selection: $selection) {
                    ForEach(Fruit.allCases) { fruit in
                        Text(fruit.rawValue).tag(fruit)
                    }
                }
                .pickerStyle(.inline)
            }

            Section("Segmented Picker") {
                Picker("Fruit", selection: $selection) {
                    ForEach(Fruit.allCases) { fruit in
                        Text(fruit.rawValue).tag(fruit)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DatePickerDemoView: View {
    @State private var date: Date = Date()
    @State private var schedule: Date = Date()

    var body: some View {
        List {
            Section("Graphical") {
                DatePicker("", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
            }
            Section("Compact (Date & Time)") {
                DatePicker("Schedule", selection: $schedule)
                    .datePickerStyle(.compact)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ColorPickerDemoView: View {
    @State private var color: Color = .blue

    var body: some View {
        List {
            ColorPicker("Pick a color", selection: $color, supportsOpacity: true)
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(height: 100)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


