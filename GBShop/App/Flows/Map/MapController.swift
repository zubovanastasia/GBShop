//
//  MapController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 15.05.2022.
//

import Foundation
import UIKit
import GoogleMaps
import Realm
import RealmSwift
import RxSwift

class MapController: UIViewController {
    @IBOutlet private weak var mapView: GMSMapView!
    private var coordinates = [CLLocationCoordinate2D]()
    private var manualMarker: GMSMarker?
    private var locationManager = LocationManager.instance
    private var route: GMSPolyline?
    private var routePath: GMSMutablePath?
    private var markers = [GMSMarker]()
    private let mapDB = RealmDB()
    private var locationsDB = [LocationObject]()
    private var task: UIBackgroundTaskIdentifier?
    private var isTracking: Bool = false
    private let disposeBag = DisposeBag()
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsDB = mapDB.getPersistedRoutes()
        configureMap()
        configureLocationManager()
        printRealmMessage()
    }
    // MARK: - Private methods.
    private func printRealmMessage() {
        print("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    private func addMarker() {
        let marker = GMSMarker()
        marker.map = mapView
        self.manualMarker = marker
    }
    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinates.last ?? CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504), zoom: 17)
        mapView.camera = camera
        mapView.animate(toLocation: coordinates.last ?? CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504))
    }
    private func configureLocationManager() {
        locationManager
            .location
            .asObservable()
            .subscribe { [weak self] location in
                guard let location = location.element?.last else {
                    return
                }
                self?.routePath?.add(location.coordinate)
                self?.route?.path  = self?.routePath
                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
                self?.coordinates.append(location.coordinate)
                self?.mapView.animate(to: position)
                self?.mapDB.saveToRealm(self!.coordinates)
            }.disposed(by: disposeBag)
    }
    private func loadRoute(_ routesArray: [LocationObject], index: Int = 0) {
        let currentRoute = routesArray[index]
        currentRoute.coordinates.forEach { coordinate in
            coordinates.append(coordinate.clLocation)
        }
    }
    // MARK: - Error alert private methods.
    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Ошибка",
                                                message: "Необходимо остановить текущее слежение.",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.mapDB.deleteAll()
            self?.mapDB.saveToRealm(self!.coordinates)
            self?.route?.map = nil
            self?.coordinates.removeAll()
            self?.locationManager.stopUpdatingLocation()
            self?.isTracking = false
        }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    // MARK: - IBAction methods.
    @IBAction private func toLocation(_ sender: Any) {
        locationManager.toLocation()
        configureMap()
    }
    @IBAction private func updateLocation(_ sender: Any) {
        locationManager.toLocation()
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        locationManager.startUpdatingLocation()
    }
    @IBAction private func markerTracking(_ sender: Any) {
        addMarker()
    }
    @IBAction private func startTrack(_ sender: Any) {
        coordinates.removeAll()
        route?.map = mapView
        locationManager.startUpdatingLocation()
        isTracking = true
    }
    @IBAction private func stopTrack(_ sender: Any) {
        markers.forEach { $0.map = nil }
        mapDB.deleteAll()
        mapDB.saveToRealm(coordinates)
        route?.map = nil
        coordinates.removeAll()
        locationManager.stopUpdatingLocation()
        isTracking = false
    }
    @IBAction private func displayLastRoute(_ sender: Any) {
        guard isTracking == false else { showErrorAlert()
            return
        }
        coordinates.removeAll()
        loadRoute(mapDB.getPersistedRoutes(), index: 0)
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        coordinates.forEach { coord in
            routePath?.add(coord)
        }
        route?.path = routePath
        route?.map = mapView
        let position = GMSCameraPosition.camera(withTarget: coordinates.middle ?? CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504), zoom: 17)
        mapView.animate(to: position)
    }
}
// MARK: - Extensions.
extension MapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if let manualMarker = manualMarker { manualMarker.position = coordinate
        } else {
            let marker = GMSMarker(position: coordinate)
            marker.map = mapView
            self.manualMarker = marker
        }
    }
}
extension GMSMapView {
    func drawPolygon(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let key = APIKeyGoogleMaps().keyMaps
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(key)")
        else {
            return
        }
        DispatchQueue.main.async {
            session.dataTask(with: url) { (data, response, error) in
                guard data != nil else {
                    return
                }
                do {
                    let route = try JSONDecoder().decode(MapPath.self, from: data!)
                    if let points = route.routes?.first?.overviewPolyline?.points {
                        self.drawPath(with: points)
                    }
                    print(route.routes?.first?.overviewPolyline?.points as Any)
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    private func drawPath(with points : String) {
        DispatchQueue.main.async {
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 3.0
            polyline.strokeColor = .green
            polyline.map = self
        }
    }
}

extension Array {
    var middle: Element? {
        guard count != 0 else {
            return nil
        }
        let index = (count > 1 ? count - 1 : count) / 2
        return self[index]
    }
}
