//
//  WaterData.swift
//  loginpage
//
//  Created by Rohan Konda on 7/2/24.
//

import Foundation
import MapKit

class WaterData {
    
    private var waterLocations: Array<Array<Any>>
                                        
    @Published var length: Int
    
    init() {
        waterLocations =
        [
            //LATITUDE LONGITUDE  NAME
            [30.26429, -97.76984, "Playscape Picnic Shelter"],
            [30.26488, -97.76805, "Pecan Grove"],
            [30.26618, -97.76610, "Cedar Grove"],
            [30.26714, -97.76186, "Lou Neff Point"],
            [30.26791, -97.75949, ""],
            [30.26817, -97.74758, "Republic Square"],
            [30.27328, -97.73629, "Lebermann Plaza"],
            [30.27354, -97.73632, "Waterloo Park"],
            [30.27399, -97.74014, "Capitol"],
            [30.27690, -97.75759, "West Austin Neighborhood Park"],
        ]
        
        length = waterLocations.count
    }
    
    func getLong(index: Int) -> Double {
        return waterLocations[index][1] as! Double;
    }
    
    func getLat(index: Int) -> Double {
        return waterLocations[index][0] as! Double;
    }
    
    func getName(index: Int) -> String {
        return waterLocations[index][2] as! String;
    }
    
    func pass() -> Array<Array<Any>> {
        return waterLocations
    }
    
    func toCoords(index: Int) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: getLat(index: index), longitude: getLong(index: index))
    }
}
