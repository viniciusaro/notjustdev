import CoreLocation

final class LiveLocationClient: NSObject, LocationClient, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager
    private var continuation: UnsafeContinuation<Location, any Error>?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func location() async throws -> Location {
        if (self.locationManager.authorizationStatus != .authorizedWhenInUse) {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.locationManager.requestLocation()
        }
        
        return try await withUnsafeThrowingContinuation { [weak self] continuation in
            self?.continuation = continuation
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus;
        if case .authorizedWhenInUse = status {
            self.locationManager.requestLocation()
        } else if case .notDetermined = status {
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.continuation?.resume(throwing: LocationClientError.unauthorized)
            self.continuation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let location = Location(latitude: latitude, longitude: longitude)
            self.continuation?.resume(returning: location)
            self.continuation = nil
            self.locationManager.stopUpdatingLocation()
        } else {
            self.continuation?.resume(throwing: LocationClientError.unavailable)
            self.continuation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("ERROR: \(error)")
    }
}
