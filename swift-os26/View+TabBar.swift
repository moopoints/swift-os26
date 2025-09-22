import SwiftUI

extension View {
    func hidesTabBarOnPush() -> some View {
        self.toolbar(.hidden, for: .tabBar)
    }
}


