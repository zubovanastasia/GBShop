//
//  Location.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 22.05.2022.
//

import Foundation
import Realm
import RealmSwift
import CoreLocation

final class Location: Object, Codable {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
    var clLocation: CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
    
    required convenience init? (clLocation: CLLocation) {
        self.init()
        self.longitude = clLocation.coordinate.longitude
        self.latitude = clLocation.coordinate.latitude
    }
    
}

final class LocationObject: Object {
    let coordinates = List<Location>()
}
