import SwiftUI

struct TextFieldsDemoView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var isEditing: Bool = false

    var body: some View {
        List {
            Section("Basic TextField") {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.words)
                    .autocorrectionDisabled(false)
            }

            Section("Keyboard Types & Submit") {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.next)

                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .textFieldStyle(.roundedBorder)
            }

            Section("Focus & Editing State") {
                HStack {
                    Text("Editing:")
                    Spacer()
                    Text(isEditing ? "Yes" : "No")
                }
                TextField("Tap to edit", text: $name, onEditingChanged: { editing in
                    isEditing = editing
                })
                .textFieldStyle(.roundedBorder)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SecureFieldsDemoView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isRevealed: Bool = false

    var body: some View {
        List {
            Section("SecureField") {
                SecureField("Password", text: $password)
                    .textContentType(.password)
            }
            Section("Confirm & Reveal") {
                if isRevealed {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                SecureField("Confirm Password", text: $confirmPassword)

                Toggle(isOn: $isRevealed) {
                    Text("Show Password")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TextEditorDemoView: View {
    @State private var notes: String = ""

    var body: some View {
        VStack(spacing: 0) {
            TextEditor(text: $notes)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
}

struct SearchDemoView: View {
    @State private var query: String = ""

    private let items: [String] = [
        "Apple", "Banana", "Cherry", "Date", "Elderberry",
        "Fig", "Grape", "Honeydew", "Kiwi", "Lemon",
        "Mango", "Nectarine", "Orange", "Papaya", "Quince"
    ]

    var filteredItems: [String] {
        if query.isEmpty { return items }
        return items.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        List(filteredItems, id: \.self) { item in
            Text(item)
        }
        .searchable(text: $query, placement: .automatic, prompt: Text("Search fruits"))
        .navigationBarTitleDisplayMode(.inline)
    }
}


