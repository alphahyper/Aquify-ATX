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
        NavigationView {
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
                    
                    /* profile link */
                    NavigationLink{
                        if (avm.userSession != nil) {
                            ProfileView()
                                .navigationBarBackButtonHidden(true)
                        }
                        else { NoUserWarningView()
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
                    
                    
                    /* map link */
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
                    
                    
                    /* settings link */
                    NavigationLink{
                        if (avm.userSession != nil) {
                            SettingsView()
                                .navigationBarBackButtonHidden(true)
                        }
                        else { NoUserWarningView()
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
}


struct MapViewPreviews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

