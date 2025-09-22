import SwiftUI

struct NavsTabView: View {
    var body: some View {
        List {
            Section("Menus & Toolbars") {
                NavigationLink("Toolbars") { ToolbarsDemoView().hidesTabBarOnPush() }
                NavigationLink("Toolbars (Glass)") { ToolbarsGlassDemoView().hidesTabBarOnPush() }
                NavigationLink("Toolbar Title Menu") { ToolbarTitleMenuDemoView().hidesTabBarOnPush() }
            }

            Section("Navigation & Tabs") {
                NavigationLink("NavigationStack") { NavigationStackDemoView().hidesTabBarOnPush() }
                NavigationLink("NavigationSplitView") { NavigationSplitViewDemo().hidesTabBarOnPush() }
                NavigationLink("TabView Styles") { TabViewStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("TabView with Search") { TabViewWithSearchRoleDemoView().hidesTabBarOnPush() }
                NavigationLink("Floating Search Overlay") { FloatingSearchOverlayDemoView().hidesTabBarOnPush() }
            }

            Section("Presentation") {
                NavigationLink("Presentation Demos") { PresentationListView().hidesTabBarOnPush() }
            }
        }
    }
}


