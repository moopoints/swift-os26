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
	private enum GradientStyle: String, CaseIterable, Identifiable {
		case bluePurple
		case icyNight
		case goldenPlum
		case steelNavy
		case roseSunset

		var id: Self { self }

		var title: String {
			switch self {
			case .bluePurple: return "Blue → Purple"
			case .icyNight: return "Cyan → Midnight"
			case .goldenPlum: return "Gold → Plum"
			case .steelNavy: return "Steel → Navy"
			case .roseSunset: return "Rose → Sunset"
			}
		}

		var gradient: LinearGradient {
			let colors: [Color]
			switch self {
			case .bluePurple:
				// #3F2B96 → #A8C0FF
				colors = [
					Color(red: 63.0/255.0, green: 43.0/255.0, blue: 150.0/255.0),
					Color(red: 168.0/255.0, green: 192.0/255.0, blue: 255.0/255.0)
				]
			case .icyNight:
				// #1CB5E0 → #000851
				colors = [
					Color(red: 28.0/255.0, green: 181.0/255.0, blue: 224.0/255.0),
					Color(red: 0.0/255.0, green: 8.0/255.0, blue: 81.0/255.0)
				]
			case .goldenPlum:
				// #FDBB2D → #3A1C71
				colors = [
					Color(red: 253.0/255.0, green: 187.0/255.0, blue: 45.0/255.0),
					Color(red: 58.0/255.0, green: 28.0/255.0, blue: 113.0/255.0)
				]
			case .steelNavy:
				// #4B6CB7 → #182848
				colors = [
					Color(red: 75.0/255.0, green: 108.0/255.0, blue: 183.0/255.0),
					Color(red: 24.0/255.0, green: 40.0/255.0, blue: 72.0/255.0)
				]
			case .roseSunset:
				// #D53369 → #DAAE51
				colors = [
					Color(red: 213.0/255.0, green: 51.0/255.0, blue: 105.0/255.0),
					Color(red: 218.0/255.0, green: 174.0/255.0, blue: 81.0/255.0)
				]
			}
			return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
		}
	}

	@State private var selectedStyle: GradientStyle = .bluePurple

	var body: some View {
		ZStack {
			selectedStyle.gradient
				.ignoresSafeArea()

			GeometryReader { proxy in
				let containerWidth: CGFloat = proxy.size.width - 32.0
				let containerHeight: CGFloat = 160.0

				ScrollView {
					VStack(spacing: 8) {
						ForEach(0..<10) { _ in
							RoundedRectangle(cornerRadius: 20)
								.frame(width: containerWidth, height: containerHeight)
								.glassEffect(in: RoundedRectangle(cornerRadius: 20))
								.opacity(0.5)
						}
					}
					.frame(maxWidth: .infinity)
					.padding(.horizontal, 16)
					.padding(.bottom, 24)
				}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Menu {
					Picker("Gradient Style", selection: $selectedStyle) {
						ForEach(GradientStyle.allCases) { style in
							Text(style.title).tag(style)
						}
					}
				} label: {
					Label("Gradient", systemImage: "paintbrush.pointed")
				}
			}
		}
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


