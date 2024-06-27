//
//  MapViewModel.swift
//  loginpage
//
//  Created by Rohan Konda on 6/27/24.
//

import Foundation
import MapKit
import CoreLocation

enum MapDet {
    static let startLoc = CLLocationCoordinate2D(latitude: 30, longitude: -96.5)
    static let defSpan = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDet.startLoc, span: MapDet.defSpan)
    
    var locationManager: CLLocationManager?
    
    //check if location services are enabled
    func checkLocServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("show alert")
        }
    }
    
    // check location authorization
    private func checkLocAuth() {
        guard let locationManager = locationManager else {return}
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("alert: restricted")
        case .denied:
            print("alert: denied")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDet.defSpan)
        @unknown default:
            break;
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocAuth()
    }
}
