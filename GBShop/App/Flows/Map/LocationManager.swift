//
//  LocationManager.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 13.06.2022.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject {
    
    static let instance = LocationManager()
    let locationManager = CLLocationManager()
    var location = BehaviorSubject(value: [CLLocation]())
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    // MARK: - Public methods.
    public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    public func toLocation() {
        locationManager.requestLocation()
    }
    // MARK: - Private methods.
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

// MARK: - Extentions.
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location.onNext(locations)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
