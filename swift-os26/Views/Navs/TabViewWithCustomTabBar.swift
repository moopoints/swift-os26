import SwiftUI
import Combine
import UIKit

// MARK: - TabView with Activity and custom glass Tab Bar (left-aligned)
struct TabViewWithCustomTabBar: View {
    @State private var selectedTab: CustomTab = .activities
    @State private var isTimerRunning: Bool = false
    @State private var secondsElapsed: Int = 0
    @State private var showFullCover: Bool = false
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let barEdgePadding: CGFloat = 28
    private let buttonWidth: CGFloat = 88
    private let buttonHeight: CGFloat = 56
    private let barInnerPadding: CGFloat = 4

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

            // Left custom tab bar layer (bottom-leading)
            VStack {
                Spacer()
                HStack {
                    CustomTabBar(
                        selectedTab: $selectedTab,
                        tabs: CustomTab.allCases,
                        itemHeight: buttonHeight,
                        itemWidth: buttonWidth,
                        containerPadding: barInnerPadding
                    )
                    Spacer()
                }
                .padding(.leading, barEdgePadding)
                .padding(.bottom, barEdgePadding)
            }

            // Right live activity bar layer (bottom-trailing)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if isTimerRunning {
                        LiveActivityTabBar(
                            timerText: timerDisplay,
                            itemWidth: buttonWidth,
                            itemHeight: buttonHeight,
                            containerPadding: barInnerPadding,
                            onTap: { showFullCover = true }
                        )
                    }
                }
                .padding(.trailing, barEdgePadding)
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
    let itemHeight: CGFloat
    let itemWidth: CGFloat
    let containerPadding: CGFloat

    var body: some View {
        HStack(spacing: -8) { tabButtons }
        .padding(containerPadding)
        .background(
            RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous)
                .stroke(Color.primary.opacity(0.08))
        )
        .shadow(color: Color.black.opacity(0.15), radius: 12, y: 4)
    }

    @ViewBuilder
    private var tabButtons: some View {
        ForEach(tabs, id: \.self) { (tab: CustomTab) in
            TabButton(
                tab: tab,
                isSelected: selectedTab == tab,
                itemWidth: itemWidth,
                itemHeight: itemHeight,
                onTap: { selectedTab = tab }
            )
        }
    }
}

struct TabButton: View {
    let tab: CustomTab
    let isSelected: Bool
    let itemWidth: CGFloat
    let itemHeight: CGFloat
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
                .frame(width: 28, height: 28)
                .foregroundStyle(isSelected ? Color.accentColor : Color.primary)
        }
        .frame(width: itemWidth, height: itemHeight)
        .background(
            isSelected ? AnyShapeStyle(.regularMaterial) : AnyShapeStyle(Color.clear),
            in: RoundedRectangle(cornerRadius: itemWidth / 2.0, style: .continuous)
        )
    }
}

// Second, separate tab bar for live activity timer (shows only when running)
struct LiveActivityTabBar: View {
    let timerText: String
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let containerPadding: CGFloat
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
                    .frame(width: itemWidth, height: itemHeight)
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
        .padding(containerPadding)
        .background(
            RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous)
                .fill(.thinMaterial)
        )
        .contentShape(RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: (itemWidth + containerPadding) / 2, style: .continuous)
                .stroke(Color.primary.opacity(0.08))
        )
        .shadow(color: Color.black.opacity(0.15), radius: 12, y: 4)
    }
}


