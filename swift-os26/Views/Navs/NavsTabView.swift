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
                NavigationLink("TabView (UIKit Bridge)") { UIKitBridgeTabViewDemo().hidesTabBarOnPush() }
                NavigationLink("Floating Search Overlay") { FloatingSearchOverlayDemoView().hidesTabBarOnPush() }
            }

            Section("Presentation") {
                NavigationLink("Presentation Demos") { PresentationListView().hidesTabBarOnPush() }
            }
        }
    }
}



// MARK: - UIKit bridge demo

private struct UIKitBridgeTabViewDemo: View {
    var body: some View {
        TabView {
            NavigationStack {
                UIKitBridgeFirstTabView()
                    .navigationTitle("First")
            }
            .tabItem { Label("First", systemImage: "1.circle") }

            NavigationStack {
                ZStack { Color.green.ignoresSafeArea() }
                    .navigationTitle("Second")
            }
            .tabItem { Label("Second", systemImage: "2.circle") }

            NavigationStack {
                ZStack { Color.orange.ignoresSafeArea() }
                    .navigationTitle("Third")
            }
            .tabItem { Label("Third", systemImage: "3.circle") }
        }
    }
}

private struct UIKitBridgeFirstTabView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { index in
                NavigationLink {
                    UIKitBridgeDetailView(itemIndex: index)
                } label: {
                    HStack {
                        Image(systemName: "doc.text")
                        Text("Item #\(index)")
                    }
                }
            }
        }
    }
}

private struct UIKitBridgeDetailView: View {
    let itemIndex: Int

    var body: some View {
        List {
            Section("Detail") {
                Text("Detail for item #\(itemIndex)")
            }
        }
        .background(HidesBottomBarWhenPushed())
    }
}

private struct HidesBottomBarWhenPushed: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ProxyController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }

    private final class ProxyController: UIViewController {
        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            parent?.hidesBottomBarWhenPushed = true
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            parent?.hidesBottomBarWhenPushed = true
        }
    }
}
