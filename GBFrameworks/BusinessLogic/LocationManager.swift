//
//  LocationManager.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 31.05.2022.
//

import Foundation
import CoreLocation
import RxSwift

final class LocationManager: NSObject {
    static let instance = LocationManager()

    let locationManager = CLLocationManager()
    let location: BehaviorSubject<CLLocation?> = BehaviorSubject(value: nil)

    private override init() {
        super.init()
        configureLocationManager()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location.onNext(locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
