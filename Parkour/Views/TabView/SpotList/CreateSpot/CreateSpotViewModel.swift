import Foundation
import CoreLocation
import SwiftUI
import Combine

class CreateSpotViewModel: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    var cancel = Set<AnyCancellable>()
    var cancel2 = Set<AnyCancellable>()
    @Published var location: CLLocation? = nil
    @Published var city = ""
    @Published var loading = false
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func createSpot(image: UIImage, void: @escaping () -> Void) {
        let publisher = Gateway().createSpot(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, city: city)
        
        publisher.sink { error in
            print(error)
        } receiveValue: { spot in
            let publisher2 = Gateway().addImageToSpot(image: image, id: spot.id)
            publisher2.sink {error in
                self.loading = false
                print(error)
            } receiveValue: { receivedImage in
                self.loading = false
                void()
            }.store(in: &self.cancel2)
        }.store(in: &cancel)
    }
}

extension CreateSpotViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        
        location.fetchCityAndCountry {city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.city = city
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
