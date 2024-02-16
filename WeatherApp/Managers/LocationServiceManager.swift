//
//  LocationManager.swift
//  WeatherApp
//
//  Created by cem sezeroglu on 14.02.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func userLocationUpdate(location: CLLocation?)
}

class LocationServiceManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationServiceManager()
    
    var userLocationDelegate: LocationManagerDelegate?
    
    let locationManager = CLLocationManager()
    private var isLocationUpdated: Bool = false
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func checkLocationManagerAuthorization() -> Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            return true
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
            return false
        default:
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let delegate = userLocationDelegate else { return }
        
        if !isLocationUpdated {
            delegate.userLocationUpdate(location: locations.first)
            isLocationUpdated = true
        }
    }
}
