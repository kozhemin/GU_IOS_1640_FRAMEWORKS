//
//  ViewController.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 14.05.2022.
//

import CoreLocation
import GoogleMaps
import UIKit

class ViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!

    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var locationManager: CLLocationManager?
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    let zoom: Float = 17.0

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMap()
        configureLocationManager()
    }

    @IBAction func updateLocation(_: Any) {
        locationManager?.requestLocation()

        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()

        route?.map = mapView

        locationManager?.startUpdatingLocation()
    }

    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true

        mapView.delegate = self
    }

    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        routePath?.add(location.coordinate)
        route?.path = routePath

        let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: zoom)
        mapView.animate(to: position)
    }

    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
