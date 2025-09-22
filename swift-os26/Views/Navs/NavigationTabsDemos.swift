import SwiftUI
import Combine
import UIKit

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


// MARK: - TabView with Activity and conditional Search tab
struct TabViewWithActivityDemoView: View {
    @State private var showSearchTab: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    private var timerDisplay: String {
        let minutes: Int = secondsElapsed / 60
        let seconds: Int = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        ZStack {
            TabView {
                Tab("", systemImage: "1.circle") {
                    ZStack { Color.red.ignoresSafeArea() }
                }
                Tab("", systemImage: "2.circle") {
                    ZStack { Color.green.ignoresSafeArea() }
                }
                Tab("", systemImage: "3.circle") {
                    ZStack { Color.blue.ignoresSafeArea() }
                }
                if showSearchTab {
                    Tab(role: .search) {
                        Color.clear
                            .ignoresSafeArea()
                            .onAppear { showFullCover = true }
                    } label: {
                        Text(timerDisplay)
                            .font(.system(size: 12, weight: .semibold, design: .monospaced))
                            .minimumScaleFactor(0.8)
                            .lineLimit(1)
                    }
                }
            }

            Button {
                showSearchTab.toggle()
                if showSearchTab {
                    secondsElapsed = 0
                } else {
                    showFullCover = false
                }
            } label: {
                Label(showSearchTab ? "Stop Timer" : "Start Timer", systemImage: "timer")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
            }
        }
        .onReceive(timer) { (_: Date) in
            if showSearchTab {
                secondsElapsed += 1
            }
        }
        .fullScreenCover(isPresented: $showFullCover) {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                        Button("Dismiss") { showFullCover = false }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - TabView with Activity and custom glass Tab Bar (left-aligned)
struct TabViewWithActivityDemoView2: View {
    @State private var selectedIndex: Int = 0
    @State private var isTimerRunning: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let barHeight: CGFloat = 48

    private var timerDisplay: String {
        let minutes: Int = secondsElapsed / 60
        let seconds: Int = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        ZStack {
            Group {
                switch selectedIndex {
                case 0:
                    Color.red.ignoresSafeArea()
                case 1:
                    Color.green.ignoresSafeArea()
                case 2:
                    Color.blue.ignoresSafeArea()
                default:
                    Color.clear.ignoresSafeArea()
                }
            }

            // Custom glass tab bar (left-aligned, floating near bottom like native)
            VStack {
                Spacer()
                HStack(spacing: 10) {
                    // Tabs 1-3: icons only
                    glassTabButton(systemImageName: "1.circle", isSelected: selectedIndex == 0) {
                        selectedIndex = 0
                    }
                    glassTabButton(systemImageName: "2.circle", isSelected: selectedIndex == 1) {
                        selectedIndex = 1
                    }
                    glassTabButton(systemImageName: "3.circle", isSelected: selectedIndex == 2) {
                        selectedIndex = 2
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: barHeight)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(
                    Capsule().strokeBorder(Color.primary.opacity(0.1))
                )
                .shadow(color: Color.black.opacity(0.15), radius: 12, y: 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
                .padding(.bottom, 20)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if isTimerRunning {
                Button(action: { showFullCover = true }) {
                    Text(timerDisplay)
                        .font(.system(size: 13, weight: .semibold, design: .monospaced))
                }
                .buttonBorderShape(.capsule)
                .frame(height: barHeight)
                .buttonStyle(GlassButtonStyle())
                .padding(.trailing, 16)
                .padding(.bottom, 20)
            }
        }
        .overlay(alignment: .center) {
            // Start/Stop timer control centered (same UX as before)
            Button(action: {
                isTimerRunning.toggle()
                if isTimerRunning {
                    secondsElapsed = 0
                }
            }) {
                Label(isTimerRunning ? "Stop Timer" : "Start Timer", systemImage: "timer")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
            }
            .buttonStyle(.plain)
            .shadow(radius: 4)
        }
        .onReceive(timer) { (_: Date) in
            if isTimerRunning { secondsElapsed += 1 }
        }
        .fullScreenCover(isPresented: $showFullCover) {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                        Button("Dismiss") { showFullCover = false }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews
    private func glassTabButton(systemImageName: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(isSelected ? .primary : .secondary)
                .padding(10)
                .overlay(
                    Circle().strokeBorder((isSelected ? Color.primary.opacity(0.15) : Color.primary.opacity(0.08)))
                )
        }
        .buttonStyle(.plain)
        .shadow(radius: isSelected ? 4 : 2, y: 2)
    }
}



// MARK: - TabView with Start button (always-on Search tab, start icon, yellow bg on timer)
struct TabViewWithStartButtonDemoView: View {
    @State private var isTimerRunning: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            TabView {
                Tab("", systemImage: "1.circle") {
                    ZStack { Color.clear.ignoresSafeArea() }
                }
                Tab("", systemImage: "2.circle") {
                    ZStack { Color.clear.ignoresSafeArea() }
                }
                // Always-on Search role tab with play icon; turns yellow while timer runs
                Tab(role: .search) {
                    Color.clear
                        .ignoresSafeArea()
                        .onAppear { showFullCover = true }
                } label: {
                    Image(systemName: "play.circle")
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(isTimerRunning ? Color.yellow : Color.clear, in: Capsule())
                }
            }

            Button {
                let willStart: Bool = !isTimerRunning
                isTimerRunning = willStart
                if willStart { secondsElapsed = 0 }
            } label: {
                Label(isTimerRunning ? "Stop Timer" : "Start Timer", systemImage: "timer")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(.thinMaterial, in: Capsule())
            }
        }
        .onReceive(timer) { (_: Date) in
            if isTimerRunning {
                secondsElapsed += 1
            }
        }
        .fullScreenCover(isPresented: $showFullCover) {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                        Button("Dismiss") { showFullCover = false }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

