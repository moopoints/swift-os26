import SwiftUI

struct PresentationListView: View {
    var body: some View {
        List {
            NavigationLink("Sheet with Detents") { SheetsDetentsDemoView().hidesTabBarOnPush() }
            NavigationLink("Full-Screen Cover") { FullScreenCoverDemoView().hidesTabBarOnPush() }
            NavigationLink("Alert") { AlertsDemoView().hidesTabBarOnPush() }
            NavigationLink("Confirmation Dialog") { ConfirmationDialogDemoView().hidesTabBarOnPush() }
            NavigationLink("Popover") { PopoversDemoView().hidesTabBarOnPush() }
        }
    }
}


