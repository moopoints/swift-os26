import SwiftUI

struct PresentationListView: View {
    @State private var showSheet: Bool = false
    @State private var showFullCover: Bool = false
    @State private var showAlert: Bool = false
    @State private var showDialog: Bool = false
    @State private var showPopover: Bool = false

    var body: some View {
        List {
            Section("Sheet with Detents") {
                Button("Present Sheet") { showSheet = true }
            }
            Section("Full-Screen Cover") {
                Button("Present Full-Screen Cover") { showFullCover = true }
            }
            Section("Alert") {
                Button("Show Alert") { showAlert = true }
            }
            Section("Confirmation Dialog") {
                Button("Show Options") { showDialog = true }
            }
            Section("Popover") {
                Button("Show Popover") { showPopover = true }
            }
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
        .fullScreenCover(isPresented: $showFullCover) {
            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    VStack(spacing: 16) {
                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.white)
                        Button("Dismiss") { showFullCover = false }
                            .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .alert("Delete file?", isPresented: $showAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {}
        } message: {
            Text("You can’t undo this action.")
        }
        .confirmationDialog("Choose an option", isPresented: $showDialog, titleVisibility: .visible) {
            Button("Copy") {}
            Button("Duplicate") {}
            Button("Move") {}
            Button("Delete", role: .destructive) {}
        }
        .popover(isPresented: $showPopover) {
            VStack(spacing: 12) {
                Text("Popover content")
                    .font(.headline)
                Text("Tap outside to dismiss")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(width: 260)
        }
    }
}

