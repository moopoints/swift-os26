import SwiftUI
import PhotosUI
import AVKit

struct PhotosPickerDemoView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: Image? = nil

    var body: some View {
        List {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("Select Photo", systemImage: "photo.on.rectangle")
            }

            if let imageUnwrapped: Image = image {
                imageUnwrapped
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .task(id: selectedItem) {
            if let item: PhotosPickerItem = selectedItem,
               let data: Data = try? await item.loadTransferable(type: Data.self),
               let uiImage: UIImage = UIImage(data: data) {
                image = Image(uiImage: uiImage)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImageAsyncImageDemoView: View {
    var body: some View {
        List {
            Section("Local Image") {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundStyle(.blue)
            }

            Section("AsyncImage (Remote)") {
                AsyncImage(url: URL(string: "https://picsum.photos/400")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180)
                            .clipped()
                    case .failure:
                        Label("Failed to load", systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.red)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct VideoPlayerDemoView: View {
    private var player: AVPlayer {
        guard let url: URL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8") else {
            return AVPlayer()
        }
        return AVPlayer(url: url)
    }

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SFSymbolsDemoView: View {
    private let symbols: [String] = [
        "circle", "square", "triangle", "heart.fill", "star.fill", "bolt"
    ]

    @State private var animate: Bool = false

    var body: some View {
        List {
            Toggle(isOn: $animate) {
                Text("Animate")
            }

            HStack(spacing: 16) {
                ForEach(symbols, id: \.self) { name in
                    Image(systemName: name)
                        .font(.system(size: 28))
                        .symbolEffect(.bounce, options: .repeat(animate ? 3 : 0))
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


