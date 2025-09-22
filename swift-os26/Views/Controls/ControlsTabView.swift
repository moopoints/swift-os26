import SwiftUI


struct ControlsTabView: View {
    var body: some View {
        List {
            Section("Basic Controls") {
                NavigationLink("Buttons") { ButtonsDemoView().hidesTabBarOnPush() }
                NavigationLink("Toggles") { TogglesDemoView().hidesTabBarOnPush() }
                NavigationLink("Segmented Controls") { SegmentedControlsDemoView().hidesTabBarOnPush() }
                NavigationLink("Sliders") { SlidersDemoView().hidesTabBarOnPush() }
                NavigationLink("Steppers") { SteppersDemoView().hidesTabBarOnPush() }
            }

            Section("Selection & Pickers") {
                NavigationLink("Picker Styles") { PickerStylesDemoView().hidesTabBarOnPush() }
                NavigationLink("Date Picker") { DatePickerDemoView().hidesTabBarOnPush() }
                NavigationLink("Color Picker") { ColorPickerDemoView().hidesTabBarOnPush() }
            }
        }
    }
}