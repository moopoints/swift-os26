import SwiftUI

struct MoreTabView: View {
    var body: some View {
        List {
            Section("Navigation & Tabs") {
                NavigationLink("NavigationStack") { NavigationStackDemoView().hidesTabBarOnPush() }
                NavigationLink("NavigationSplitView") { NavigationSplitViewDemo().hidesTabBarOnPush() }
                NavigationLink("TabView Styles") { TabViewStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("Floating Search Overlay") { FloatingSearchOverlayDemoView().hidesTabBarOnPush() }
            }

            Section("Presentation") {
                NavigationLink("Presentation Demos") { PresentationListView().hidesTabBarOnPush() }
            }
        }
    }
}


