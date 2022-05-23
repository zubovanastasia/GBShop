//
//  RealmDB.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 21.05.2022.
//

import Foundation
import Realm
import RealmSwift
import CoreLocation

final class MapRealmDB {
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }
    public func save(_ items: [Location]) {
        let realm = try! Realm()
        do {
            try! realm.write {
                realm.add(items)
            }
        }
    }
    public func saveToRealm(_ coordinates: [CLLocation]) {
        let locationObject = LocationObject()
        let realm = try! Realm()
        coordinates.forEach { coordinate in
            let location = Location()
            location.latitude = coordinate.coordinate.latitude
            location.longitude = coordinate.coordinate.longitude
            locationObject.coordinates.append(location)
        }
        do {
            try! realm.write {
                realm.add(locationObject)
            }
        }
    }
    public func load() -> Results<Location> {
        let realm = try! Realm()
        let locations: Results<Location> = realm.objects(Location.self)
        return locations
    }
    public func delete(_ items: [Location]) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(items)
        }
    }
    public func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    func getPersistedRoutes() -> [LocationObject] {
        let realm = try! Realm()
        return Array(realm.objects(LocationObject.self))
    }
}
