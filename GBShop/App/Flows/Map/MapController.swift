//
//  MapController.swift
//  GBShop
//
//  Created by Anastasiia Zubova on 15.05.2022.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController {
    @IBOutlet private weak var mapView: GMSMapView!
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var marker: GMSMarker?
    var manualMarker: GMSMarker?
    var locationManager: CLLocationManager?
    var geocoder: CLGeocoder?
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    
    // MARK: - ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
    }
    // MARK: - Private methods.
    private func addMarker() {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        self.marker = marker
    }
    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
        mapView.animate(toLocation: coordinate)
    }
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
    }
    // MARK: - IBAction methods.
    @IBAction private func toLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    @IBAction private func updateLocation(_ sender: Any) {
        locationManager?.requestLocation()
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        locationManager?.startUpdatingLocation()
    }
    @IBAction private func markerTracking(_ sender: Any) {
      addMarker()
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
extension MapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let location = locations.last else {
            return
        }
        routePath?.add(location.coordinate)
        route?.path = routePath
        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 17)
        mapView.animate(to: position)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
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
