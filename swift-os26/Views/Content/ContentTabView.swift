import SwiftUI

struct ContentTabView: View {
    var body: some View {
        List {
            Section("Lists & Grids") {
                NavigationLink("List Styles") { ListStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("Swipe Actions") { SwipeActionsDemoView().hidesTabBarOnPush() }
                NavigationLink("Reordering") { ReorderingDemoView().hidesTabBarOnPush() }
                NavigationLink("Disclosure / Outline") { DisclosureOutlineDemoView().hidesTabBarOnPush() }
                NavigationLink("Disclosure Group") { DisclosureGroupDemoView().hidesTabBarOnPush() }
                NavigationLink("Grids") { GridsDemoView().hidesTabBarOnPush() }
                NavigationLink("Forms & Rows") { FormsRowsDemoView().hidesTabBarOnPush() }
                NavigationLink("Scroll UX") { ScrollUXDemoView().hidesTabBarOnPush() }
            }

            Section("Media") {
                NavigationLink("Image & AsyncImage") { ImageAsyncImageDemoView().hidesTabBarOnPush() }
                NavigationLink("Photos Picker") { PhotosPickerDemoView().hidesTabBarOnPush() }
                NavigationLink("VideoPlayer") { VideoPlayerDemoView().hidesTabBarOnPush() }
                NavigationLink("SF Symbols") { SFSymbolsDemoView().hidesTabBarOnPush() }
            }

            Section("Status & Utilities") {
                NavigationLink("Progress, Gauges & Empty States") { NativeStatusDemoView().hidesTabBarOnPush() }
                NavigationLink("Share, Paste & Control Groups") { NativeUtilityDemoView().hidesTabBarOnPush() }
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

            Section("Charts") {
                NavigationLink("Charts") { ChartsDemoListView().hidesTabBarOnPush() }
            }
            
            Section("Maps") {
                NavigationLink("Map Test") { MapTestView().hidesTabBarOnPush() }
            }
        }
    }
}

