//
//  ViewController.swift
//  loginpage
//
//  Created by Rohan Konda on 6/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var camera: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.3, longitude: -97.75), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    
    @StateObject private var vm = MapViewModel()
    
    var body: some View {
        Map(position: $camera) {
            UserAnnotation()
        }
            .onAppear {
                vm.checkLocServices()
            }
            .alert(isPresented: $vm.showLSPAlert) {
                Alert(title: Text("Alert"), message: Text("this sucks"))
            }
    }
}


struct MapViewPreviews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var showLSPAlert: Bool = false;
    @Published var locServicesProper = true {
        didSet {
            if !locServicesProper {
                showLSPAlert = true;
            }
        }
    }
    
    var locationManager: CLLocationManager?
    //?
    func checkLocServices() {
        let myQueue = DispatchQueue(label: "custQ")
        myQueue.async { [self] in
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager?.delegate = self;
                //!
            } else {
                locServicesProper = false;
                checkLocAuth()
            }
        }
    }
    
    private func checkLocAuth() {
        
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocAuth()
    }
}
