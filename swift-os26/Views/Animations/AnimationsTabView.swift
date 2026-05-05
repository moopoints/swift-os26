import SwiftUI

struct AnimationsTabView: View {
    var body: some View {
        List {
            Section("Native Animation APIs") {
                NavigationLink("Implicit vs Explicit") { ImplicitExplicitAnimationDemoView().hidesTabBarOnPush() }
                NavigationLink("Spring Tuning") { SpringTuningDemoView().hidesTabBarOnPush() }
                NavigationLink("Transitions Gallery") { TransitionsGalleryDemoView().hidesTabBarOnPush() }
                NavigationLink("Symbol Effects") { SymbolEffectsLabView().hidesTabBarOnPush() }
                NavigationLink("Content Transitions") { ContentTransitionsDemoView().hidesTabBarOnPush() }
                NavigationLink("Phase Animator") { PhaseAnimatorDemoView().hidesTabBarOnPush() }
                NavigationLink("Keyframe Animator") { KeyframeAnimatorDemoView().hidesTabBarOnPush() }
                NavigationLink("Matched Geometry") { MatchedGeometryLabView().hidesTabBarOnPush() }
                NavigationLink("Transactions") { TransactionsDemoView().hidesTabBarOnPush() }
            }

            Section("Custom Interaction Patterns") {
                NavigationLink("Button to Custom Sheet") { ButtonToCustomSheetDemoView().hidesTabBarOnPush() }
                NavigationLink("List Row to Editable Card") { RowToEditableCardDemoView().hidesTabBarOnPush() }
                NavigationLink("Floating Action Menu") { FloatingActionMenuDemoView().hidesTabBarOnPush() }
                NavigationLink("Expandable Settings Group") { ExpandableSettingsGroupDemoView().hidesTabBarOnPush() }
                NavigationLink("Swipe Card Stack") { SwipeCardStackDemoView().hidesTabBarOnPush() }
            }

            Section("Microinteractions") {
                NavigationLink("Inline Validation") { InlineValidationDemoView().hidesTabBarOnPush() }
                NavigationLink("Success Completion") { SuccessCompletionDemoView().hidesTabBarOnPush() }
            }
        }
    }
}

struct AnimationDemoSurface<Content: View>: View {
    let title: String
    let subtitle: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            content
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

struct AnimationLabContainer<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                content
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

