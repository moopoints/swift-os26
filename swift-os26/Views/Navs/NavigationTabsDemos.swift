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
struct TabViewWithCustomTabBar: View {
    @State private var selectedTab: CustomTab = .activities
    @State private var isTimerRunning: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let barHeight: CGFloat = 60
    private let barEdgePadding: CGFloat = 28
    private let tabItemWidth: CGFloat = 80

    private var timerDisplay: String {
        let minutes: Int = secondsElapsed / 60
        let seconds: Int = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .activities:
                    Color.red.ignoresSafeArea()
                case .routes:
                    Color.green.ignoresSafeArea()
                case .workouts:
                    Color.blue.ignoresSafeArea()
                }
            }

            // Custom glass tab bars (left: navigation, right: live activity pill)
            VStack {
                Spacer()
                HStack(spacing: 8) {
                    CustomTabBar(
                        selectedTab: $selectedTab,
                        tabs: CustomTab.allCases,
                        itemHeight: barHeight,
                        itemWidth: tabItemWidth
                    )
                    Spacer()
                    if isTimerRunning {
                        LiveActivityTabBar(
                            timerText: timerDisplay,
                            width: tabItemWidth,
                            height: barHeight,
                            onTap: { showFullCover = true }
                        )
                    }
                }
                .padding(.horizontal, barEdgePadding)
                .padding(.bottom, barEdgePadding)
            }
        }
        .ignoresSafeArea(edges: .bottom)
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

}



// MARK: - Custom Tab Bar Components (local, asset-based)

enum CustomTab: CaseIterable, Hashable {
    case activities, routes, workouts

    func iconName(isSelected: Bool) -> String {
        switch self {
        case .activities: return isSelected ? "tab-activity-filled" : "tab-activity"
        case .routes: return isSelected ? "tab-routes-filled" : "tab-routes"
        case .workouts: return isSelected ? "tab-workouts-filled" : "tab-workouts"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: CustomTab
    var tabs: [CustomTab]
    var itemHeight: CGFloat = 48
    var itemWidth: CGFloat = 64

    var body: some View {
        HStack(spacing: 4) {
            ForEach(tabs, id: \.self) { tab in
                TabButton(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    itemHeight: itemHeight,
                    itemWidth: itemWidth,
                    onTap: { selectedTab = tab }
                )
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(Color.primary.opacity(0.08))
        )
        .shadow(color: Color.black.opacity(0.15), radius: 12, y: 4)
    }
}

struct TabButton: View {
    let tab: CustomTab
    let isSelected: Bool
    let itemHeight: CGFloat
    let itemWidth: CGFloat
    let onTap: () -> Void

    var body: some View {
        Button(action: {
            let impactFeedback: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
            onTap()
        }) {
            Image(tab.iconName(isSelected: isSelected))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundStyle(isSelected ? Color.accentColor : Color.primary)
        }
        .frame(width: itemWidth, height: itemHeight)
        .background(
            isSelected ? AnyShapeStyle(.regularMaterial) : AnyShapeStyle(Color.clear),
            in: RoundedRectangle(cornerRadius: itemHeight / 2.0, style: .continuous)
        )
    }
}

// Second, separate tab bar for live activity timer (shows only when running)
struct LiveActivityTabBar: View {
    let timerText: String
    let width: CGFloat
    let height: CGFloat
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Button(action: {
                let impactFeedback: UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
                onTap()
            }) {
                Text(timerText)
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color.primary)
                    .frame(width: width, height: height)
                    .contentShape(Capsule())
            }
            .buttonStyle(.plain)
            .background(
                Capsule()
                    .fill(.regularMaterial)
                    .overlay(
                        Capsule().fill(Color.yellow.opacity(0.6))
                    )
            )
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .stroke(Color.primary.opacity(0.08))
        )
        .shadow(color: Color.black.opacity(0.15), radius: 12, y: 4)
    }
}

// MARK: - TabView with Start button (always-on Search tab)
/// Demo notes:
/// - The trailing start button uses `Tab(role: .search)` so it sits in the accessory zone.
/// - UIKit's tab bar normalizes per-item views; most label styling is ignored (tint/foreground,
///   backgrounds, overlays, shadows, and symbol/implicit animations). Content changes do reflect
///   (e.g. switching symbol name/variant or showing text like a timer/LIVE).
/// - We intercept selection via `TabView(selection:)` so this start button never remains selected;
///   after tapping (sheet opens), selection reverts to the last real tab (1 or 2).
struct TabViewWithStartButtonDemoView: View {
    @State private var isTimerRunning: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State private var selectedTab: Int = 1
    @State private var lastNonStartTab: Int = 1

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Tab("", systemImage: "1.circle", value: 1) {
                    ZStack { Color.clear.ignoresSafeArea() }
                }
                Tab("", systemImage: "2.circle", value: 2) {
                    ZStack { Color.clear.ignoresSafeArea() }
                }
                // Always-on trailing start button (search-role) that never stays selected
                // Styling note: Tab bar ignores most label modifiers (tint/foreground, backgrounds,
                // overlays, shadows, runtime animations). Prefer content changes (symbol/text) to
                // indicate running state.
                Tab(value: 999, role: .search) {
                    Color.clear
                        .ignoresSafeArea()
                } label: {
                    Image(systemName: "play.circle")
                        .foregroundStyle(isTimerRunning ? Color.accentColor : Color.primary)
                        .symbolEffect(.pulse, isActive: isTimerRunning)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .overlay(
                            Capsule()
                                .stroke(isTimerRunning ? Color.accentColor : Color.clear, lineWidth: isTimerRunning ? 2 : 0)
                        )
                        .shadow(color: isTimerRunning ? Color.accentColor.opacity(0.6) : Color.clear, radius: isTimerRunning ? 8 : 0)
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
        .onChange(of: selectedTab) { (newValue: Int) in
            if newValue == 999 {
                showFullCover = true
                // Immediately restore to the last non-start tab so the start button never appears selected
                DispatchQueue.main.async {
                    selectedTab = lastNonStartTab
                }
            } else {
                lastNonStartTab = newValue
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

