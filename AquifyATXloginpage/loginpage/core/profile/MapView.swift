//
//  ViewController.swift
//  loginpage
//
//  Created by Rohan Konda on 6/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject var avm: AuthViewModel
    
    @State var camera: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.3, longitude: -97.75), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
    
    @StateObject private var vm = MapViewModel()
    
    var wd = WaterData()
    var wdlength = WaterData().length
    
    var body: some View {
        VStack {
            Map(position: $camera) {
                ForEach(0...(wd.length - 1), id: \.self) { ind in
                    Marker(wd.getName(index: ind), coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(wd.getLat(index: ind)), longitude: CLLocationDegrees(wd.getLong(index: ind))))
                }
                
      
                UserAnnotation()
            }
                .onAppear {
                    vm.checkLocServices()
                }
                .alert(isPresented: $vm.showLSPAlert) {
                    Alert(title: Text("Alert"), message: Text("this sucks"))
                }
            HStack {
                NavigationLink{
                    if (avm.userSession == nil) {
                        NoUserWarningView()
                    }
                    else { MapView()
                            .navigationBarBackButtonHidden(true)
                    }
                } label:{
                    HStack(spacing: 2){
                        Text("Profile")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
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
