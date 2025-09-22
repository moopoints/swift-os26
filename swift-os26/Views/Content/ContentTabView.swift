import SwiftUI

struct ContentTabView: View {
    var body: some View {
        List {
            Section("Lists & Grids") {
                NavigationLink("List Styles") { ListStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("Swipe Actions") { SwipeActionsDemoView().hidesTabBarOnPush() }
                NavigationLink("Reordering") { ReorderingDemoView().hidesTabBarOnPush() }
                NavigationLink("Disclosure / Outline") { DisclosureOutlineDemoView().hidesTabBarOnPush() }
                NavigationLink("Grids") { GridsDemoView().hidesTabBarOnPush() }
            }

            Section("Media") {
                NavigationLink("Photos Picker") { PhotosPickerDemoView().hidesTabBarOnPush() }
                NavigationLink("VideoPlayer") { VideoPlayerDemoView().hidesTabBarOnPush() }
                NavigationLink("SF Symbols") { SFSymbolsDemoView().hidesTabBarOnPush() }
            }

            Section("Layout & Effects") {
                NavigationLink("Layouts") { LayoutsDemoView().hidesTabBarOnPush() }
                NavigationLink("Backgrounds & Materials") { BackgroundsMaterialsDemoView().hidesTabBarOnPush() }
                NavigationLink("Shapes & Gradients") { ShapesGradientsDemoView().hidesTabBarOnPush() }
                NavigationLink("Animations") { AnimationsDemoView().hidesTabBarOnPush() }
                NavigationLink("Transitions") { TransitionsDemoView().hidesTabBarOnPush() }
                NavigationLink("matchedGeometryEffect") { MatchedGeometryDemoView().hidesTabBarOnPush() }
                NavigationLink("Sensory Feedback") { SensoryFeedbackDemoView().hidesTabBarOnPush() }
            }
        }
    }
}


