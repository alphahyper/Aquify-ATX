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
                    Marker(wd.getName(index: ind), systemImage: "drop.fill", coordinate: wd.toCoords(index: ind))
                        .tint(.blue)
                }
                
      
                UserAnnotation()
            }
                .onAppear {
                    vm.checkLocServices()
                }
                .alert(isPresented: $vm.showLSPAlert) {
                    Alert(title: Text("Alert"), message: Text("this sucks"))
                }
            HStack(spacing: 30) {
                NavigationLink{
                    if (avm.userSession == nil) {
                        NoUserWarningView()
                    }
                    else { MapView()
                            .navigationBarBackButtonHidden(true)
                    }
                } label:{
                    VStack(spacing: 4){
                        Image(systemName: "person.crop.circle")
                            .padding()
                            .scaledToFit()
                            .font(.system(size: 30))
                        Text("Profile")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                    }
                }
                
                NavigationLink{
                    MapView()
                            .navigationBarBackButtonHidden(true)
                } label:{
                    VStack(spacing: 4){
                        Image(systemName: "map.fill")
                            .padding()
                            .scaledToFit()
                            .font(.system(size: 30))
                        Text("Map")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                    }
                }
                
                NavigationLink{
                    if (avm.userSession == nil) {
                        NoUserWarningView()
                    }
                    else { MapView()
                            .navigationBarBackButtonHidden(true)
                    }
                } label:{
                    VStack(spacing: 4){
                        Image(systemName: "gear")
                            .padding()
                            .scaledToFit()
                            .font(.system(size: 30))
                        Text("Settings")
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                    }
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
