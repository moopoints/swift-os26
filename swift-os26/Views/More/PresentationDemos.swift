import SwiftUI

struct SheetsDetentsDemoView: View {
    @State private var showSheet: Bool = false
    var body: some View {
        List {
            Button("Present Sheet") { showSheet = true }
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                VStack(spacing: 16) {
                    Text("Sheet With Detents")
                        .font(.headline)
                    Text("Scroll or drag to change detent")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") { showSheet = false }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FullScreenCoverDemoView: View {
    @State private var showCover: Bool = false
    var body: some View {
        List {
            Button("Present Full-Screen Cover") { showCover = true }
        }
        .fullScreenCover(isPresented: $showCover) {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                        Button("Dismiss") { showCover = false }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AlertsDemoView: View {
    @State private var showAlert: Bool = false
    @State private var result: String = ""
    var body: some View {
        List {
            Button("Show Alert") { showAlert = true }
            Text("Result: \(result)")
        }
        .alert("Delete file?", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {
                result = "Cancelled"
            }
            Button("Delete", role: .destructive) {
                result = "Deleted"
            }
        } message: {
            Text("You can’t undo this action.")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ConfirmationDialogDemoView: View {
    @State private var showDialog: Bool = false
    @State private var selection: String = ""
    var body: some View {
        List {
            Button("Show Options") { showDialog = true }
            Text("Picked: \(selection)")
        }
        .confirmationDialog("Choose an option", isPresented: $showDialog, titleVisibility: .visible) {
            Button("Copy") { selection = "Copy" }
            Button("Duplicate") { selection = "Duplicate" }
            Button("Move") { selection = "Move" }
            Button("Delete", role: .destructive) { selection = "Delete" }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PopoversDemoView: View {
    @State private var showPopover: Bool = false
    var body: some View {
        List {
            Button("Show Popover") { showPopover = true }
        }
        .popover(isPresented: $showPopover) {
            VStack(spacing: 12) {
                Text("Popover content")
                    .font(.headline)
                Text("Tap outside to dismiss")
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


