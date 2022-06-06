//
//  ViewController.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 14.05.2022.
//

import CoreLocation
import GoogleMaps
import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!

    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)

    var zoom: Float = 17.0
    let locationManager = LocationManager.instance
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var routeManager: RouteManagerProtocol?

    var onExit: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        coufigureRouteManager()
        configureMap()
        configureLocationManager()
    }

    @IBAction func startRoute(_: Any) {
        locationManager.requestLocation()

        routeInit()

        locationManager.startUpdatingLocation()
        routeManager?.start()
    }

    @IBAction func endRoute(_: Any) {
        locationManager.stopUpdatingLocation()
        routeManager?.stop()
    }

    @IBAction func viewLastRoute(_: Any) {
        guard let routeManager = routeManager else { return }
        if !routeManager.canViewLastTrack() {
            showAlert(m: "Сначала завершите маршрут!")
            return
        }

        routeInit()

        routeManager.getLastTrack { items in
            var firstCoordinate: CLLocationCoordinate2D?
            items?.forEach { item in
                self.routePath?.add(item.coordinate)
                self.route?.path = self.routePath

                if firstCoordinate == nil {
                    firstCoordinate = item.coordinate
                }
            }

            if let coodinate = firstCoordinate {
                let position = GMSCameraPosition.camera(withTarget: coodinate, zoom: self.zoom)
                self.mapView.animate(to: position)
            }
        }
    }

    @IBAction func tapExit(_: Any) {
        UserDefaults.isLogin = false
        onExit?()
    }

    private func routeInit() {
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()

        route?.map = mapView
    }

    private func showAlert(m: String) {
        let alert = UIAlertController(title: "Error", message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoom)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true

        mapView.delegate = self
    }

    private func configureLocationManager() {
        locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let location = location else { return }
                
                self?.routePath?.add(location.coordinate)
                self?.route?.path = self?.routePath

                let position = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: self?.zoom ?? 17)
                self?.mapView.animate(to: position)
                
                self?.routeManager?.track(coodinate: location.coordinate)
            }
    }

    private func coufigureRouteManager() {
        routeManager = RouteManager()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }
}
