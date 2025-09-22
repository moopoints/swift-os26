import SwiftUI

struct LayoutsDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 8).fill(.blue.opacity(0.3)).frame(height: 60)
                    RoundedRectangle(cornerRadius: 8).fill(.green.opacity(0.3)).frame(height: 60)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8).fill(.orange.opacity(0.3)).frame(height: 100)
                    Text("ZStack")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BackgroundsMaterialsDemoView: View {
    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .frame(height: 120)
                .overlay(Text("ultraThinMaterial"))
            RoundedRectangle(cornerRadius: 16)
                .fill(.thinMaterial)
                .frame(height: 120)
                .overlay(Text("thinMaterial"))
        }
        .padding()
        .background(
            LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShapesGradientsDemoView: View {
    var body: some View {
        List {
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom))
                .frame(height: 120)
            Circle()
                .stroke(AngularGradient(colors: [.blue, .green, .blue], center: .center), lineWidth: 6)
                .frame(height: 120)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AnimationsDemoView: View {
    @State private var isOn: Bool = false
    var body: some View {
        VStack(spacing: 24) {
            RoundedRectangle(cornerRadius: 12)
                .fill(isOn ? .green : .gray)
                .frame(width: isOn ? 220 : 120, height: 80)
                .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isOn)
            Button("Toggle") { isOn.toggle() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransitionsDemoView: View {
    @State private var show: Bool = true
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                if show {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.blue)
                        .frame(height: 120)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            Button(show ? "Hide" : "Show") { withAnimation { show.toggle() } }
                .buttonStyle(.bordered)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MatchedGeometryDemoView: View {
    @Namespace private var ns
    @State private var expanded: Bool = false

    var body: some View {
        VStack(spacing: 24) {
            if expanded {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.mint)
                    .matchedGeometryEffect(id: "card", in: ns)
                    .frame(height: 180)
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.mint)
                    .matchedGeometryEffect(id: "card", in: ns)
                    .frame(height: 80)
            }
            Button("Toggle") { withAnimation(.spring()) { expanded.toggle() } }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SensoryFeedbackDemoView: View {
    @State private var count: Int = 0
    var body: some View {
        List {
            Button("Increment") {
                count += 1
            }
            Text("Count: \(count)")
        }
        .sensoryFeedback(.impact(weight: .medium, intensity: 0.9), trigger: count)
        .navigationBarTitleDisplayMode(.inline)
    }
}


