import SwiftUI

struct ButtonToCustomSheetDemoView: View {
    @Namespace private var namespace
    @State private var isPresented: Bool = false
    @State private var note: String = ""
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            AnimationLabContainer {
                AnimationDemoSurface(title: "Button to custom sheet", subtitle: "A button expands into a custom surface using matched geometry.") {
                    Button {
                        withAnimation(.spring(duration: 0.55, bounce: 0.18)) {
                            isPresented = true
                        }
                    } label: {
                        Label("New Note", systemImage: "plus")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                    .buttonStyle(.borderedProminent)
                    .matchedGeometryEffect(id: "sheet", in: namespace)
                }
            }

            if isPresented {
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture { dismiss() }

                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        Capsule()
                            .fill(.secondary.opacity(0.35))
                            .frame(width: 42, height: 5)
                            .frame(maxWidth: .infinity)

                        Text("New Note")
                            .font(.title2.bold())

                        TextField("What should this remember?", text: $note, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                            .lineLimit(3...5)

                        HStack {
                            Button("Cancel") { dismiss() }
                                .buttonStyle(.bordered)
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                Label("Done", systemImage: "checkmark")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding()
                    .background(.background, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
                    .matchedGeometryEffect(id: "sheet", in: namespace)
                    .offset(y: max(0, dragOffset))
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                if value.translation.height > 90 {
                                    dismiss()
                                }
                            }
                    )
                    .padding()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    private func dismiss() {
        withAnimation(.spring(duration: 0.45, bounce: 0.12)) {
            isPresented = false
        }
    }
}

struct RowToEditableCardDemoView: View {
    struct Item: Identifiable {
        let id: Int
        var title: String
        var note: String
    }

    @Namespace private var namespace
    @State private var items: [Item] = [
        Item(id: 1, title: "Morning review", note: "Check native components."),
        Item(id: 2, title: "Animation study", note: "Practice expansion patterns."),
        Item(id: 3, title: "Prototype polish", note: "Tune springs and focus.")
    ]
    @State private var editingID: Int? = nil
    @FocusState private var isNoteFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach($items) { $item in
                    if editingID == item.id {
                        VStack(alignment: .leading, spacing: 12) {
                            TextField("Title", text: $item.title)
                                .font(.title3.bold())
                            TextField("Note", text: $item.note, axis: .vertical)
                                .lineLimit(4...7)
                                .focused($isNoteFocused)

                            HStack {
                                Spacer()
                                Button {
                                    withAnimation(.spring(duration: 0.45, bounce: 0.16)) {
                                        editingID = nil
                                        isNoteFocused = false
                                    }
                                } label: {
                                    Label("Done", systemImage: "checkmark")
                                }
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        .padding()
                        .background(.background, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                        .matchedGeometryEffect(id: item.id, in: namespace)
                        .onAppear { isNoteFocused = true }
                    } else {
                        HStack(spacing: 12) {
                            Image(systemName: "note.text")
                                .foregroundStyle(.blue)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.note)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .background(.background, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .matchedGeometryEffect(id: item.id, in: namespace)
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.5, bounce: 0.18)) {
                                editingID = item.id
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FloatingActionMenuDemoView: View {
    @State private var isOpen: Bool = false
    private let actions: [(String, String, Color)] = [
        ("Scan", "viewfinder", .blue),
        ("Photo", "camera.fill", .green),
        ("Write", "pencil", .orange)
    ]

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List(1...18, id: \.self) { item in
                Label("Action target \(item)", systemImage: "doc.text")
            }

            VStack(alignment: .trailing, spacing: 12) {
                ForEach(Array(actions.enumerated()), id: \.offset) { index, action in
                    Button { } label: {
                        Label(action.0, systemImage: action.1)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .background(action.2, in: Capsule())
                            .foregroundStyle(.white)
                    }
                    .scaleEffect(isOpen ? 1 : 0.5)
                    .opacity(isOpen ? 1 : 0)
                    .offset(y: isOpen ? 0 : 18)
                    .animation(.spring(duration: 0.38, bounce: 0.24).delay(Double(index) * 0.045), value: isOpen)
                }

                Button {
                    withAnimation(.spring(duration: 0.42, bounce: 0.2)) {
                        isOpen.toggle()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .rotationEffect(.degrees(isOpen ? 45 : 0))
                        .frame(width: 58, height: 58)
                        .background(.blue, in: Circle())
                        .foregroundStyle(.white)
                }
                .shadow(color: .blue.opacity(0.35), radius: 14, y: 8)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExpandableSettingsGroupDemoView: View {
    @State private var isExpanded: Bool = false
    @State private var blur: Double = 0.2
    @State private var saturation: Double = 0.7
    @State private var reduceMotion: Bool = false

    var body: some View {
        AnimationLabContainer {
            VStack(alignment: .leading, spacing: 14) {
                Button {
                    withAnimation(.spring(duration: 0.48, bounce: 0.16)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Label("Visual Effects", systemImage: "slider.horizontal.3")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    }
                }
                .buttonStyle(.plain)

                if isExpanded {
                    VStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Blur")
                                Spacer()
                                Text(blur.formatted(.number.precision(.fractionLength(2))))
                                    .foregroundStyle(.secondary)
                            }
                            Slider(value: $blur)
                        }
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("Saturation")
                                Spacer()
                                Text(saturation.formatted(.number.precision(.fractionLength(2))))
                                    .foregroundStyle(.secondary)
                            }
                            Slider(value: $saturation)
                        }
                        Toggle("Reduce motion preview", isOn: $reduceMotion)
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}

struct SwipeCardStackDemoView: View {
    struct Card: Identifiable {
        let id: Int
        let title: String
        let color: Color
    }

    @State private var cards: [Card] = [
        Card(id: 1, title: "Prototype", color: .blue),
        Card(id: 2, title: "Animate", color: .purple),
        Card(id: 3, title: "Polish", color: .orange)
    ]
    @State private var drag: CGSize = .zero

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Swipe stack", subtitle: "Drag the top card; release far enough to dismiss.") {
                ZStack {
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        let isTop = index == cards.count - 1
                        RoundedRectangle(cornerRadius: 26, style: .continuous)
                            .fill(card.color.gradient)
                            .frame(height: 260)
                            .overlay {
                                Text(card.title)
                                    .font(.largeTitle.bold())
                                    .foregroundStyle(.white)
                            }
                            .scaleEffect(1 - CGFloat(cards.count - 1 - index) * 0.05)
                            .offset(y: CGFloat(cards.count - 1 - index) * 14)
                            .offset(isTop ? drag : .zero)
                            .rotationEffect(.degrees(isTop ? Double(drag.width / 18) : 0))
                            .gesture(
                                isTop ? DragGesture()
                                    .onChanged { drag = $0.translation }
                                    .onEnded { value in
                                        if abs(value.translation.width) > 120 {
                                            withAnimation(.snappy) {
                                                _ = cards.popLast()
                                                drag = .zero
                                            }
                                        } else {
                                            withAnimation(.spring(duration: 0.45, bounce: 0.2)) {
                                                drag = .zero
                                            }
                                        }
                                    } : nil
                            )
                    }

                    if cards.isEmpty {
                        ContentUnavailableView("No Cards", systemImage: "rectangle.stack")
                            .frame(height: 260)
                    }
                }

                Button("Reset") {
                    withAnimation(.spring(duration: 0.45, bounce: 0.16)) {
                        cards = [
                            Card(id: 1, title: "Prototype", color: .blue),
                            Card(id: 2, title: "Animate", color: .purple),
                            Card(id: 3, title: "Polish", color: .orange)
                        ]
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct InlineValidationDemoView: View {
    @State private var text: String = ""
    @State private var attempts: Int = 0
    @State private var isInvalid: Bool = false

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Validation shake", subtitle: "A custom GeometryEffect moves the field on failed submit.") {
                TextField("Type at least 4 characters", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .modifier(ShakeEffect(animatableData: CGFloat(attempts)))
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isInvalid ? .red : .clear, lineWidth: 1.5)
                    }

                Button("Submit") {
                    if text.count < 4 {
                        isInvalid = true
                        withAnimation(.linear(duration: 0.45)) {
                            attempts += 1
                        }
                    } else {
                        withAnimation(.snappy) {
                            isInvalid = false
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: sin(animatableData * .pi * 6) * 8, y: 0))
    }
}

struct SuccessCompletionDemoView: View {
    @State private var isComplete: Bool = false
    @State private var trigger: Int = 0

    var body: some View {
        AnimationLabContainer {
            AnimationDemoSurface(title: "Completion", subtitle: "Combine symbol replacement, scale, and sensory feedback.") {
                Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 86))
                    .foregroundStyle(isComplete ? .green : .secondary)
                    .contentTransition(.symbolEffect(.replace))
                    .symbolEffect(.bounce, value: trigger)
                    .scaleEffect(isComplete ? 1.08 : 1)

                Button(isComplete ? "Reset" : "Complete") {
                    withAnimation(.bouncy(duration: 0.55, extraBounce: 0.2)) {
                        isComplete.toggle()
                        trigger += 1
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .sensoryFeedback(.success, trigger: isComplete)
    }
}
