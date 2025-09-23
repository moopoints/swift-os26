import SwiftUI
import MapKit
import CoreLocation

struct MapTestView: View {
    @StateObject private var locationManager: ExampleLocationManager = ExampleLocationManager()

    // MARK: - State
    @State private var cameraPosition: MapCameraPosition = .userLocation(
        followsHeading: true,
        fallback: .automatic
    )
    @State private var isFollowingUser: Bool = true
    @State private var isFollowingWithHeading: Bool = true
    @State private var currentDistance: Double = 0
    @State private var lastUserInteractionTime: Date?
    @State private var returnToUserTimer: Timer?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Simple inline nav bar replacement
            HStack(spacing: 12) {
                Button("Back") {}
                    .font(.headline)
                Spacer()
                Text("Map View")
                    .font(.headline)
                Spacer()
                Color.clear.frame(width: 44, height: 1)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)

            // Manual control buttons
            HStack {
                Button(action: { followUser(withHeading: false) }) {
                    Image(systemName: "location")
                        .padding(8)
                }
                Button(action: { followUser(withHeading: true) }) {
                    Image(systemName: "location.north.fill")
                        .padding(8)
                }
                Button(action: setDefaultZoom) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding(8)
                }
                Button(action: zoomAndTransition) {
                    Image(systemName: "arrow.down.forward.and.arrow.up.backward.circle")
                        .padding(8)
                }
            }
            .padding()

            Map(
                position: $cameraPosition,
                bounds: MapCameraBounds(minimumDistance: 700),
                interactionModes: [.pan, .rotate, .zoom]
            ) {
                UserAnnotation()
            }
            .mapControls {
                MapScaleView()
                MapUserLocationButton()
                if cameraPosition.positionedByUser {
                    MapCompass()
                }
            }
            .mapStyle(.standard(
                elevation: .flat,
                pointsOfInterest: .excludingAll,
                showsTraffic: false
            ))
            .onMapCameraChange(frequency: .onEnd) { context in
                currentDistance = context.camera.distance
                if cameraPosition.positionedByUser {
                    isFollowingUser = false
                    isFollowingWithHeading = false
                    lastUserInteractionTime = Date()
                    startReturnToUserTimer()
                }
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Distance from ground: \(Int(currentDistance))m")
                    .font(.footnote)
                    .foregroundColor(.white)
                Text("Following with heading: \(isFollowingWithHeading ? \"On\" : \"Off\")")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .padding()
            .background(.black.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
        }
        .onAppear {
            locationManager.requestLocation()
            followUser(withHeading: true)
        }
        .onDisappear {
            returnToUserTimer?.invalidate()
        }
    }

    // MARK: - Functions
    func startReturnToUserTimer() {
        returnToUserTimer?.invalidate()
        returnToUserTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { _ in
            if let lastInteraction: Date = lastUserInteractionTime,
               Date().timeIntervalSince(lastInteraction) >= 10 {
                followUser(withHeading: true)
            }
        }
    }

    func followUser(withHeading: Bool) {
        withAnimation {
            isFollowingUser = true
            isFollowingWithHeading = withHeading
            cameraPosition = .userLocation(
                followsHeading: withHeading,
                fallback: .automatic
            )
        }
    }

    func setDefaultZoom() {
        if let userLocation: CLLocationCoordinate2D = locationManager.location?.coordinate,
           let currentHeading: CLLocationDirection = locationManager.heading?.trueHeading {
            withAnimation {
                cameraPosition = .camera(MapCamera(
                    centerCoordinate: userLocation,
                    distance: 500,
                    heading: currentHeading
                ))
            }
        }
    }

    func zoomAndTransition() {
        if let userLocation: CLLocationCoordinate2D = locationManager.location?.coordinate {
            withAnimation {
                cameraPosition = .camera(MapCamera(
                    centerCoordinate: userLocation,
                    distance: 1000,
                    heading: 0
                ))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                followUser(withHeading: true)
            }
        }
    }
}

class ExampleLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager: CLLocationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var heading: CLHeading?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingHeading()
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading
    }
}


