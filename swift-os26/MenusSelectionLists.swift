import SwiftUI

// Section list views referenced by ContentView tabs

private extension View {
    func hidesTabBarOnPush() -> some View {
        self.toolbar(.hidden, for: .tabBar)
    }
}

struct ControlsListView: View {
    var body: some View {
        List {
            NavigationLink("Buttons") { ButtonsDemoView().hidesTabBarOnPush() }
            NavigationLink("Toggles") { TogglesDemoView().hidesTabBarOnPush() }
            NavigationLink("Segmented Controls") { SegmentedControlsDemoView().hidesTabBarOnPush() }
            NavigationLink("Sliders") { SlidersDemoView().hidesTabBarOnPush() }
            NavigationLink("Steppers") { SteppersDemoView().hidesTabBarOnPush() }
        }
    }
}

struct SelectionPickersListView: View {
    var body: some View {
        List {
            NavigationLink("Picker Styles") { PickerStylesDemoView().hidesTabBarOnPush() }
            NavigationLink("Date Picker") { DatePickerDemoView().hidesTabBarOnPush() }
            NavigationLink("Color Picker") { ColorPickerDemoView().hidesTabBarOnPush() }
        }
    }
}

struct MenusToolbarsListView: View {
    var body: some View {
        List {
            NavigationLink("Menus") { MenusDemoView().hidesTabBarOnPush() }
            NavigationLink("Context Menus") { ContextMenusDemoView().hidesTabBarOnPush() }
            NavigationLink("Toolbars") { ToolbarsDemoView().hidesTabBarOnPush() }
            NavigationLink("Toolbar Title Menu") { ToolbarTitleMenuDemoView().hidesTabBarOnPush() }
        }
    }
}

struct ListsGridsListView: View {
    var body: some View {
        List {
            NavigationLink("List Styles") { ListStylesDemoView().hidesTabBarOnPush() }
            NavigationLink("Swipe Actions") { SwipeActionsDemoView().hidesTabBarOnPush() }
            NavigationLink("Reordering") { ReorderingDemoView().hidesTabBarOnPush() }
            NavigationLink("Disclosure / Outline") { DisclosureOutlineDemoView().hidesTabBarOnPush() }
            NavigationLink("Grids") { GridsDemoView().hidesTabBarOnPush() }
        }
    }
}

struct NavigationTabsListView: View {
    var body: some View {
        List {
            NavigationLink("NavigationStack") { NavigationStackDemoView().hidesTabBarOnPush() }
            NavigationLink("NavigationSplitView") { NavigationSplitViewDemo().hidesTabBarOnPush() }
            NavigationLink("TabView Styles") { TabViewStylesDemoView().hidesTabBarOnPush() }
            NavigationLink("Floating Search Overlay") { FloatingSearchOverlayDemoView().hidesTabBarOnPush() }
        }
    }
}

struct PresentationListView: View {
    var body: some View {
        List {
            NavigationLink("Sheets with Detents") { SheetsDetentsDemoView().hidesTabBarOnPush() }
            NavigationLink("Full-Screen Cover") { FullScreenCoverDemoView().hidesTabBarOnPush() }
            NavigationLink("Alerts") { AlertsDemoView().hidesTabBarOnPush() }
            NavigationLink("Confirmation Dialogs") { ConfirmationDialogDemoView().hidesTabBarOnPush() }
            NavigationLink("Popovers") { PopoversDemoView().hidesTabBarOnPush() }
        }
    }
}

struct MediaListView: View {
    var body: some View {
        List {
            NavigationLink("PhotosPicker") { PhotosPickerDemoView().hidesTabBarOnPush() }
            NavigationLink("Image & AsyncImage") { ImageAsyncImageDemoView().hidesTabBarOnPush() }
            NavigationLink("VideoPlayer") { VideoPlayerDemoView().hidesTabBarOnPush() }
            NavigationLink("SF Symbols") { SFSymbolsDemoView().hidesTabBarOnPush() }
        }
    }
}

struct LayoutEffectsListView: View {
    var body: some View {
        List {
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


