import SwiftUI
import Charts

struct ChartsDemoListView: View {
    var body: some View {
        List {
            Section("Line Charts") {
                NavigationLink("Basic Time Series") { LineChartBasicView().hidesTabBarOnPush() }
                NavigationLink("Line + Area Gradient") { LineAreaGradientView().hidesTabBarOnPush() }
                NavigationLink("Multi-series with Legend") { LineMultiSeriesLegendView().hidesTabBarOnPush() }
                NavigationLink("Live-updating Line") { LineLiveUpdatingView().hidesTabBarOnPush() }
            }

            Section("Bar Charts") {
                NavigationLink("Bar – Categorical Totals") { BarChartBasicView().hidesTabBarOnPush() }
                NavigationLink("Grouped Bars") { BarChartGroupedView().hidesTabBarOnPush() }
                NavigationLink("Stacked Bars") { BarChartStackedView().hidesTabBarOnPush() }
                NavigationLink("Range Bar (Min–Max)") { RangeBarChartView().hidesTabBarOnPush() }
            }

            Section("Other") {
                NavigationLink("Scatter – Size & Color Encodings") { ScatterEncodedView().hidesTabBarOnPush() }
                NavigationLink("Heatmap Grid") { HeatmapGridView().hidesTabBarOnPush() }
                NavigationLink("Pie / Donut") { PieDonutChartView().hidesTabBarOnPush() }
                NavigationLink("Histogram (Binned)") { HistogramBinnedView().hidesTabBarOnPush() }
                NavigationLink("Custom Box Plot") { BoxPlotCustomView().hidesTabBarOnPush() }
                NavigationLink("Mixed Bars + Line Overlay") { MixedBarLineOverlayView().hidesTabBarOnPush() }
            }
        }
        .navigationTitle("Charts")
    }
}

// MARK: - Line – Basic time series

struct LineChartBasicView: View {
    struct DataPoint: Identifiable {
        let id: UUID = UUID()
        let date: Date
        let value: Double
    }

    private let data: [DataPoint]

    init() {
        var points: [DataPoint] = []
        let calendar: Calendar = Calendar.current
        let start: Date = Date().addingTimeInterval(-7 * 24 * 60 * 60)
        for dayOffset in 0..<30 {
            if let date: Date = calendar.date(byAdding: .day, value: dayOffset, to: start) {
                let value: Double = 50 + sin(Double(dayOffset) / 4.0) * 15 + Double.random(in: -5...5)
                points.append(DataPoint(date: date, value: value))
            }
        }
        self.data = points
    }

    var body: some View {
        Chart(self.data) { point in
            LineMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            PointMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .foregroundStyle(.secondary)
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 6))
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .padding()
        .navigationTitle("Basic Time Series")
    }
}

// MARK: - Line + Area gradient

struct LineAreaGradientView: View {
    struct DataPoint: Identifiable {
        let id: UUID = UUID()
        let date: Date
        let value: Double
    }

    private let data: [DataPoint]

    init() {
        var points: [DataPoint] = []
        let calendar: Calendar = Calendar.current
        let start: Date = Date().addingTimeInterval(-14 * 24 * 60 * 60)
        for dayOffset in 0..<60 {
            if let date: Date = calendar.date(byAdding: .day, value: dayOffset, to: start) {
                let base: Double = 80 + cos(Double(dayOffset) / 6.0) * 25
                let value: Double = base + Double.random(in: -6...6)
                points.append(DataPoint(date: date, value: value))
            }
        }
        self.data = points
    }

    var body: some View {
        Chart(self.data) { point in
            AreaMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .foregroundStyle(.linearGradient(colors: [.blue.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom))

            LineMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .foregroundStyle(.blue)
        }
        .chartXAxis { AxisMarks(values: .automatic(desiredCount: 8)) }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Line + Area Gradient")
    }
}

// MARK: - Multi-series line with legend

struct LineMultiSeriesLegendView: View {
    struct SeriesPoint: Identifiable {
        let id: UUID = UUID()
        let date: Date
        let value: Double
        let series: String
    }

    private let data: [SeriesPoint]

    init() {
        var rows: [SeriesPoint] = []
        let calendar: Calendar = Calendar.current
        let start: Date = Date().addingTimeInterval(-21 * 24 * 60 * 60)
        for dayOffset in 0..<40 {
            if let date: Date = calendar.date(byAdding: .day, value: dayOffset, to: start) {
                rows.append(SeriesPoint(date: date, value: 40 + sin(Double(dayOffset) / 5.0) * 15, series: "Alpha"))
                rows.append(SeriesPoint(date: date, value: 55 + cos(Double(dayOffset) / 4.0) * 12, series: "Beta"))
                rows.append(SeriesPoint(date: date, value: 60 + sin(Double(dayOffset) / 3.0) * 8, series: "Gamma"))
            }
        }
        self.data = rows
    }

    var body: some View {
        Chart(self.data) { point in
            LineMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .foregroundStyle(by: .value("Series", point.series))

            PointMark(
                x: .value("Date", point.date),
                y: .value("Value", point.value)
            )
            .foregroundStyle(by: .value("Series", point.series))
        }
        .chartLegend(position: .automatic)
        .chartXAxis { AxisMarks(values: .automatic(desiredCount: 6)) }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Multi-series Line")
    }
}

// MARK: - Live-updating line

struct LineLiveUpdatingView: View {
    struct DataPoint: Identifiable { let id: UUID = UUID(); let time: Date; let value: Double }

    @State private var data: [DataPoint] = []
    @State private var timer: Timer? = nil

    private let windowSize: Int = 40

    var body: some View {
        VStack {
            Chart(self.data) { point in
                LineMark(
                    x: .value("Time", point.time),
                    y: .value("Value", point.value)
                )
            }
            .chartXAxis { AxisMarks(values: .automatic(desiredCount: 5)) }
            .chartYAxis { AxisMarks(position: .leading) }
            .frame(height: 240)
            .padding(.horizontal)

            Text("Streaming random data")
                .foregroundStyle(.secondary)
                .padding(.bottom)
        }
        .onAppear { self.start() }
        .onDisappear { self.stop() }
        .navigationTitle("Live-updating Line")
    }

    private func start() {
        let initialNow: Date = Date()
        self.data = (0..<self.windowSize).map { offset in
            DataPoint(time: initialNow.addingTimeInterval(Double(offset - self.windowSize) * 0.5), value: 50 + Double.random(in: -10...10))
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let now: Date = Date()
            let next: DataPoint = DataPoint(time: now, value: 50 + Double.random(in: -10...10))
            self.data.append(next)
            if self.data.count > self.windowSize { self.data.removeFirst(self.data.count - self.windowSize) }
        }
    }

    private func stop() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

// MARK: - Bar – Categorical totals

struct BarChartBasicView: View {
    struct CategoryAmount: Identifiable { let id: UUID = UUID(); let category: String; let amount: Double }
    private let data: [CategoryAmount] = [
        CategoryAmount(category: "A", amount: 12),
        CategoryAmount(category: "B", amount: 32),
        CategoryAmount(category: "C", amount: 18),
        CategoryAmount(category: "D", amount: 26)
    ]

    var body: some View {
        Chart(self.data) { row in
            BarMark(
                x: .value("Category", row.category),
                y: .value("Amount", row.amount)
            )
            .annotation(position: .top, alignment: .center) {
                Text(String(format: "%.0f", row.amount))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Bar – Totals")
    }
}

// MARK: - Grouped bars

struct BarChartGroupedView: View {
    struct Entry: Identifiable { let id: UUID = UUID(); let category: String; let subcategory: String; let amount: Double }
    private let data: [Entry] = [
        Entry(category: "Q1", subcategory: "iOS", amount: 24),
        Entry(category: "Q1", subcategory: "macOS", amount: 18),
        Entry(category: "Q1", subcategory: "watchOS", amount: 12),
        Entry(category: "Q2", subcategory: "iOS", amount: 30),
        Entry(category: "Q2", subcategory: "macOS", amount: 16),
        Entry(category: "Q2", subcategory: "watchOS", amount: 14),
        Entry(category: "Q3", subcategory: "iOS", amount: 28),
        Entry(category: "Q3", subcategory: "macOS", amount: 20),
        Entry(category: "Q3", subcategory: "watchOS", amount: 15)
    ]

    var body: some View {
        Chart(self.data) { row in
            BarMark(
                x: .value("Quarter", row.category),
                y: .value("Amount", row.amount)
            )
            .foregroundStyle(by: .value("Platform", row.subcategory))
            .position(by: .value("Platform", row.subcategory))
        }
        .chartLegend(position: .automatic)
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Grouped Bars")
    }
}

// MARK: - Stacked bars

struct BarChartStackedView: View {
    struct Entry: Identifiable { let id: UUID = UUID(); let category: String; let subcategory: String; let amount: Double }
    private let data: [Entry] = [
        Entry(category: "North", subcategory: "A", amount: 20),
        Entry(category: "North", subcategory: "B", amount: 12),
        Entry(category: "South", subcategory: "A", amount: 15),
        Entry(category: "South", subcategory: "B", amount: 18),
        Entry(category: "East", subcategory: "A", amount: 22),
        Entry(category: "East", subcategory: "B", amount: 10),
        Entry(category: "West", subcategory: "A", amount: 19),
        Entry(category: "West", subcategory: "B", amount: 13)
    ]

    var body: some View {
        Chart(self.data) { row in
            BarMark(
                x: .value("Region", row.category),
                y: .value("Amount", row.amount)
            )
            .foregroundStyle(by: .value("Type", row.subcategory))
        }
        .chartLegend(position: .automatic)
        .chartPlotStyle { plotArea in
            plotArea
        }
        .padding()
        .navigationTitle("Stacked Bars")
    }
}

// MARK: - Range bar (min–max)

struct RangeBarChartView: View {
    struct RangeSample: Identifiable { let id: UUID = UUID(); let category: String; let lower: Double; let upper: Double }
    private let data: [RangeSample] = [
        RangeSample(category: "A", lower: 12, upper: 28),
        RangeSample(category: "B", lower: 18, upper: 36),
        RangeSample(category: "C", lower: 10, upper: 24),
        RangeSample(category: "D", lower: 20, upper: 30)
    ]

    var body: some View {
        Chart(self.data) { row in
            BarMark(
                x: .value("Category", row.category),
                yStart: .value("Min", row.lower),
                yEnd: .value("Max", row.upper)
            )
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Range Bar")
    }
}

// MARK: - Scatter with size/color encoding

struct ScatterEncodedView: View {
    struct Sample: Identifiable { let id: UUID = UUID(); let x: Double; let y: Double; let size: Double; let category: String }
    private let samples: [Sample] = (0..<80).map { _ in
        Sample(x: Double.random(in: 0...100), y: Double.random(in: 0...100), size: Double.random(in: 10...200), category: ["Alpha", "Beta", "Gamma"].randomElement()!)
    }

    var body: some View {
        Chart(self.samples) { s in
            PointMark(
                x: .value("X", s.x),
                y: .value("Y", s.y)
            )
            .foregroundStyle(by: .value("Category", s.category))
            .symbolSize(by: .value("Size", s.size))
        }
        .chartLegend(position: .automatic)
        .padding()
        .navigationTitle("Scatter Encodings")
    }
}

// MARK: - Heatmap grid

struct HeatmapGridView: View {
    struct Cell: Identifiable { let id: UUID = UUID(); let xIndex: Int; let yIndex: Int; let value: Double }
    private let cells: [Cell]

    init() {
        var temp: [Cell] = []
        for x in 0..<12 {
            for y in 0..<8 {
                temp.append(Cell(xIndex: x, yIndex: y, value: Double.random(in: 0...1)))
            }
        }
        self.cells = temp
    }

    var body: some View {
        Chart(self.cells) { cell in
            RectangleMark(
                x: .value("X", cell.xIndex),
                y: .value("Y", cell.yIndex)
            )
            .foregroundStyle(by: .value("Value", cell.value))
        }
        .chartXAxis { AxisMarks(values: .stride(by: 1)) }
        .chartYAxis { AxisMarks(values: .stride(by: 1)) }
        .padding()
        .navigationTitle("Heatmap Grid")
    }
}

// MARK: - Pie / Donut

struct PieDonutChartView: View {
    struct Slice: Identifiable { let id: UUID = UUID(); let category: String; let value: Double }
    private let data: [Slice] = [
        Slice(category: "Red", value: 35),
        Slice(category: "Green", value: 20),
        Slice(category: "Blue", value: 25),
        Slice(category: "Yellow", value: 12),
        Slice(category: "Purple", value: 8)
    ]

    @State private var isDonut: Bool = true

    var body: some View {
        VStack {
            Chart(self.data) { slice in
                SectorMark(
                    angle: .value("Value", slice.value),
                    innerRadius: self.isDonut ? .ratio(0.6) : .ratio(0.0)
                )
                .foregroundStyle(by: .value("Category", slice.category))
            }
            .chartLegend(position: .automatic)
            .frame(height: 260)
            .padding(.horizontal)

            Toggle(isOn: self.$isDonut) {
                Text("Donut Style")
            }
            .padding()
        }
        .navigationTitle("Pie / Donut")
    }
}

// MARK: - Histogram (binned)

struct HistogramBinnedView: View {
    struct Sample: Identifiable { let id: UUID = UUID(); let value: Double }
    private let raw: [Sample] = (0..<500).map { _ in Sample(value: Double.random(in: 0...100)) }

    private struct Bin: Identifiable { let id: UUID = UUID(); let label: String; let count: Int }

    private var bins: [Bin] {
        let binSize: Double = 10
        var buckets: [Int: Int] = [:]
        for s in self.raw {
            let index: Int = min(Int(s.value / binSize), 9)
            buckets[index, default: 0] += 1
        }
        return (0..<10).map { idx in
            let rangeStart: Int = Int(Double(idx) * binSize)
            let rangeEnd: Int = Int(Double(idx + 1) * binSize)
            let label: String = "\(rangeStart)-\(rangeEnd)"
            let count: Int = buckets[idx, default: 0]
            return Bin(label: label, count: count)
        }
    }

    var body: some View {
        Chart(self.bins) { b in
            BarMark(
                x: .value("Bin", b.label),
                y: .value("Count", b.count)
            )
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Histogram (Binned)")
    }
}

// MARK: - Custom Box Plot

struct BoxPlotCustomView: View {
    struct Series: Identifiable { let id: UUID = UUID(); let name: String; let values: [Double] }
    private let series: [Series] = [
        Series(name: "A", values: (0..<40).map { _ in Double.random(in: 10...40) }),
        Series(name: "B", values: (0..<40).map { _ in Double.random(in: 20...60) }),
        Series(name: "C", values: (0..<40).map { _ in Double.random(in: 30...80) })
    ]

    private func quantiles(values: [Double]) -> (min: Double, q1: Double, median: Double, q3: Double, max: Double) {
        let sorted: [Double] = values.sorted()
        func q(_ p: Double) -> Double { sorted[Int(Double(sorted.count - 1) * p)] }
        return (sorted.first ?? 0, q(0.25), q(0.5), q(0.75), sorted.last ?? 0)
    }

    var body: some View {
        Chart {
            ForEach(self.series) { s in
                let q: (min: Double, q1: Double, median: Double, q3: Double, max: Double) = self.quantiles(values: s.values)

                // Whiskers
                RuleMark(
                    x: .value("Series", s.name),
                    yStart: .value("Min", q.min),
                    yEnd: .value("Max", q.max)
                )

                // IQR box
                RectangleMark(
                    x: .value("Series", s.name),
                    yStart: .value("Q1", q.q1),
                    yEnd: .value("Q3", q.q3)
                )
                .foregroundStyle(.blue.opacity(0.4))

                // Median line
                RuleMark(
                    y: .value("Median", q.median)
                )
                .foregroundStyle(.blue)
            }
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Custom Box Plot")
    }
}

// MARK: - Mixed bars + line overlay

struct MixedBarLineOverlayView: View {
    struct Entry: Identifiable { let id: UUID = UUID(); let category: String; let value: Double; let target: Double }
    private let data: [Entry] = [
        Entry(category: "Jan", value: 24, target: 20),
        Entry(category: "Feb", value: 28, target: 22),
        Entry(category: "Mar", value: 20, target: 24),
        Entry(category: "Apr", value: 26, target: 24),
        Entry(category: "May", value: 30, target: 26),
        Entry(category: "Jun", value: 27, target: 26)
    ]

    var body: some View {
        Chart {
            ForEach(self.data) { row in
                BarMark(
                    x: .value("Month", row.category),
                    y: .value("Value", row.value)
                )
            }

            // Overlay target line
            ForEach(self.data) { row in
                LineMark(
                    x: .value("Month", row.category),
                    y: .value("Target", row.target)
                )
                .foregroundStyle(.red)
            }

            RuleMark(y: .value("Threshold", 25.0))
                .foregroundStyle(.secondary)
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
        }
        .chartYAxis { AxisMarks(position: .leading) }
        .padding()
        .navigationTitle("Bars + Line Overlay")
    }
}


