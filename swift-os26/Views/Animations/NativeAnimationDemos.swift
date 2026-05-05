import SwiftUI

struct ImplicitExplicitAnimationDemoView: View {
    @State private var implicitExpanded: Bool = false
    @State private var explicitExpanded: Bool = false

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Implicit", subtitle: ".animation(_:value:) follows a state value.") {
                RoundedRectangle(cornerRadius: implicitExpanded ? 28 : 10, style: .continuous)
                    .fill(implicitExpanded ? .green : .blue)
                    .frame(width: implicitExpanded ? 240 : 120, height: 84)
                    .animation(.spring(response: 0.45, dampingFraction: 0.72), value: implicitExpanded)

                Button("Toggle implicit") {
                    implicitExpanded.toggle()
                }
                .buttonStyle(.borderedProminent)
            }

            AnimationDemoSurface(title: "Explicit", subtitle: "withAnimation wraps the state change itself.") {
                RoundedRectangle(cornerRadius: explicitExpanded ? 28 : 10, style: .continuous)
                    .fill(explicitExpanded ? .orange : .purple)
                    .frame(width: explicitExpanded ? 240 : 120, height: 84)

                Button("Toggle explicit") {
                    withAnimation(.bouncy(duration: 0.65, extraBounce: 0.18)) {
                        explicitExpanded.toggle()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct SpringTuningDemoView: View {
    enum SpringPreset: String, CaseIterable, Identifiable {
        case smooth = "Smooth"
        case snappy = "Snappy"
        case bouncy = "Bouncy"
        case custom = "Custom"

        var id: String { rawValue }
    }

    @State private var preset: SpringPreset = .snappy
    @State private var bounce: Double = 0.3
    @State private var duration: Double = 0.55
    @State private var moved: Bool = false

    private var animation: Animation {
        switch preset {
        case .smooth:
            return .smooth(duration: duration)
        case .snappy:
            return .snappy(duration: duration)
        case .bouncy:
            return .bouncy(duration: duration, extraBounce: bounce)
        case .custom:
            return .spring(duration: duration, bounce: bounce)
        }
    }

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Spring presets", subtitle: "Tune duration and bounce, then replay.") {
                Picker("Preset", selection: $preset) {
                    ForEach(SpringPreset.allCases) { preset in
                        Text(preset.rawValue).tag(preset)
                    }
                }
                .pickerStyle(.segmented)

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Duration")
                        Spacer()
                        Text(duration.formatted(.number.precision(.fractionLength(2))))
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $duration, in: 0.2...1.4)
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Bounce")
                        Spacer()
                        Text(bounce.formatted(.number.precision(.fractionLength(2))))
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $bounce, in: 0...0.8)
                }

                ZStack(alignment: moved ? .trailing : .leading) {
                    Capsule()
                        .fill(.secondary.opacity(0.18))
                        .frame(height: 74)

                    Circle()
                        .fill(.blue.gradient)
                        .frame(width: 58, height: 58)
                        .padding(8)
                }
                .frame(height: 74)

                Button("Replay") {
                    withAnimation(animation) {
                        moved.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct TransitionsGalleryDemoView: View {
    enum TransitionKind: String, CaseIterable, Identifiable {
        case opacity = "Opacity"
        case move = "Move"
        case scale = "Scale"
        case asymmetric = "Asymmetric"

        var id: String { rawValue }

        var transition: AnyTransition {
            switch self {
            case .opacity:
                return .opacity
            case .move:
                return .move(edge: .bottom).combined(with: .opacity)
            case .scale:
                return .scale(scale: 0.78).combined(with: .opacity)
            case .asymmetric:
                return .asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                )
            }
        }
    }

    @State private var kind: TransitionKind = .asymmetric
    @State private var isVisible: Bool = true

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Transitions", subtitle: "Insertion and removal animation for conditional views.") {
                Picker("Transition", selection: $kind) {
                    ForEach(TransitionKind.allCases) { kind in
                        Text(kind.rawValue).tag(kind)
                    }
                }
                .pickerStyle(.segmented)

                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.secondary.opacity(0.12))
                        .frame(height: 170)

                    if isVisible {
                        VStack(spacing: 8) {
                            Image(systemName: "rectangle.stack.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.blue)
                            Text(kind.rawValue)
                                .font(.headline)
                        }
                        .frame(width: 190, height: 118)
                        .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .transition(kind.transition)
                    }
                }
                .clipped()

                Button(isVisible ? "Hide" : "Show") {
                    withAnimation(.snappy) {
                        isVisible.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct SymbolEffectsLabView: View {
    @State private var trigger: Int = 0
    @State private var isPulsing: Bool = false
    @State private var isConnected: Bool = false

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Discrete effects", subtitle: "Trigger a one-shot bounce.") {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 58))
                    .foregroundStyle(.orange)
                    .symbolEffect(.bounce, value: trigger)

                Button("Bounce") {
                    trigger += 1
                }
                .buttonStyle(.borderedProminent)
            }

            AnimationDemoSurface(title: "Indefinite effects", subtitle: "Pulse while active.") {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 58))
                    .foregroundStyle(.blue)
                    .symbolEffect(.pulse, isActive: isPulsing)

                Toggle("Pulse", isOn: $isPulsing)
            }

            AnimationDemoSurface(title: "Content replacement", subtitle: "Animate symbol changes as content changes.") {
                Image(systemName: isConnected ? "wifi" : "wifi.slash")
                    .font(.system(size: 58))
                    .foregroundStyle(isConnected ? .green : .secondary)
                    .contentTransition(.symbolEffect(.replace))

                Button(isConnected ? "Disconnect" : "Connect") {
                    withAnimation(.snappy) {
                        isConnected.toggle()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct ContentTransitionsDemoView: View {
    @State private var count: Int = 12
    @State private var isComplete: Bool = false

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Numeric text", subtitle: "Content transitions animate value replacement.") {
                Text(count, format: .number)
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .contentTransition(.numericText())

                HStack {
                    Button("-1") {
                        withAnimation(.snappy) {
                            count -= 1
                        }
                    }
                    Button("+1") {
                        withAnimation(.snappy) {
                            count += 1
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }

            AnimationDemoSurface(title: "Status label", subtitle: "Icon and label change together.") {
                Label(isComplete ? "Complete" : "In Progress", systemImage: isComplete ? "checkmark.circle.fill" : "clock.fill")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(isComplete ? .green : .orange)
                    .contentTransition(.symbolEffect(.replace))

                Button("Toggle Status") {
                    withAnimation(.bouncy) {
                        isComplete.toggle()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct PhaseAnimatorDemoView: View {
    enum Phase: CaseIterable {
        case idle
        case lift
        case glow

        var scale: CGFloat {
            switch self {
            case .idle: return 1
            case .lift: return 1.08
            case .glow: return 1.03
            }
        }

        var y: CGFloat {
            switch self {
            case .idle: return 0
            case .lift: return -16
            case .glow: return -8
            }
        }

        var shadow: CGFloat {
            switch self {
            case .idle: return 8
            case .lift: return 22
            case .glow: return 16
            }
        }
    }

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "PhaseAnimator", subtitle: "A repeating sequence of named visual phases.") {
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .fill(.blue.gradient)
                    .frame(height: 160)
                    .overlay {
                        VStack(spacing: 8) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 42))
                            Text("Breathing Card")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                    }
                    .phaseAnimator(Phase.allCases) { view, phase in
                        view
                            .scaleEffect(phase.scale)
                            .offset(y: phase.y)
                            .shadow(color: .blue.opacity(0.35), radius: phase.shadow, y: phase.shadow / 2)
                    } animation: { phase in
                        switch phase {
                        case .idle: return .smooth(duration: 0.7)
                        case .lift: return .bouncy(duration: 0.55, extraBounce: 0.12)
                        case .glow: return .smooth(duration: 0.8)
                        }
                    }
            }
        }
    }
}

struct KeyframeAnimatorDemoView: View {
    struct TapValues {
        var scale: CGFloat = 1
        var rotation: Angle = .zero
        var y: CGFloat = 0
    }

    @State private var trigger: Int = 0

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "KeyframeAnimator", subtitle: "Script a multi-step press, overshoot, and settle.") {
                Button {
                    trigger += 1
                } label: {
                    Label("Save", systemImage: "tray.and.arrow.down.fill")
                        .font(.title3.weight(.semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                }
                .buttonStyle(.borderedProminent)
                .keyframeAnimator(initialValue: TapValues(), trigger: trigger) { view, value in
                    view
                        .scaleEffect(value.scale)
                        .rotationEffect(value.rotation)
                        .offset(y: value.y)
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.86, duration: 0.12)
                        SpringKeyframe(1.12, duration: 0.24, spring: .bouncy)
                        SpringKeyframe(1.0, duration: 0.26, spring: .smooth)
                    }
                    KeyframeTrack(\.rotation) {
                        CubicKeyframe(.degrees(-4), duration: 0.12)
                        CubicKeyframe(.degrees(5), duration: 0.14)
                        CubicKeyframe(.zero, duration: 0.2)
                    }
                    KeyframeTrack(\.y) {
                        CubicKeyframe(8, duration: 0.12)
                        CubicKeyframe(-8, duration: 0.18)
                        CubicKeyframe(0, duration: 0.22)
                    }
                }
            }
        }
    }
}

struct MatchedGeometryLabView: View {
    @Namespace private var namespace
    @State private var selection: Int? = nil

    private let colors: [Color] = [.blue, .green, .orange, .purple]

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(colors.indices, id: \.self) { index in
                        if selection != index {
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(colors[index].gradient)
                                .matchedGeometryEffect(id: index, in: namespace)
                                .frame(height: 130)
                                .overlay(alignment: .bottomLeading) {
                                    Text("Card \(index + 1)")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                        .padding()
                                }
                                .onTapGesture {
                                    withAnimation(.spring(duration: 0.55, bounce: 0.24)) {
                                        selection = index
                                    }
                                }
                        }
                    }
                }
                .padding()
            }

            if let selection {
                Color.black.opacity(0.24)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.45, bounce: 0.16)) {
                            self.selection = nil
                        }
                    }

                VStack(alignment: .leading, spacing: 16) {
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(colors[selection].gradient)
                        .matchedGeometryEffect(id: selection, in: namespace)
                        .frame(height: 260)
                        .overlay(alignment: .bottomLeading) {
                            Text("Expanded Card \(selection + 1)")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                                .padding()
                        }

                    Text("The same geometry id carries size, position, and shape between two layouts.")
                        .foregroundStyle(.secondary)

                    Button("Close") {
                        withAnimation(.spring(duration: 0.45, bounce: 0.16)) {
                            self.selection = nil
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.background, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

struct TransactionsDemoView: View {
    @State private var isExpanded: Bool = false
    @State private var badgeCount: Int = 1

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Transactions", subtitle: "Animate one change while disabling animation for another.") {
                HStack {
                    RoundedRectangle(cornerRadius: isExpanded ? 22 : 10, style: .continuous)
                        .fill(.purple.gradient)
                        .frame(width: isExpanded ? 180 : 88, height: 76)

                    Spacer()

                    Text("\(badgeCount)")
                        .font(.title.bold())
                        .contentTransition(.numericText())
                        .padding()
                        .background(.secondary.opacity(0.16), in: Circle())
                }

                Button("Change Both") {
                    withAnimation(.bouncy) {
                        isExpanded.toggle()
                    }

                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        badgeCount += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
