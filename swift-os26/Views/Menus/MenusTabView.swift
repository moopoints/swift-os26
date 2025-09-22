import SwiftUI

struct MenusTabView: View {
    var body: some View {
        List {
            Section("Menus & Toolbars") {
                NavigationLink("Menus") { MenusDemoView().hidesTabBarOnPush() }
                NavigationLink("Context Menus") { ContextMenusDemoView().hidesTabBarOnPush() }
                NavigationLink("Toolbars") { ToolbarsDemoView().hidesTabBarOnPush() }
                NavigationLink("Toolbar Title Menu") { ToolbarTitleMenuDemoView().hidesTabBarOnPush() }
            }

            Section("Navigation & Tabs") {
                NavigationLink("NavigationStack") { NavigationStackDemoView().hidesTabBarOnPush() }
                NavigationLink("NavigationSplitView") { NavigationSplitViewDemo().hidesTabBarOnPush() }
                NavigationLink("TabView Styles") { TabViewStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("Floating Search Overlay") { FloatingSearchOverlayDemoView().hidesTabBarOnPush() }
            }
        }
    }
}


