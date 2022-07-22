//
//  ViewController.swift
//  LocationTracker
//
//  Created by Long Nguyen on 22/7/2022.
//

import UIKit
import MapKit
import CoreLocation
import OSLog

class ViewController: UIViewController {
    
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var startPauseButton: UIButton!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var speedLabel: UILabel!
    
    let defaultLocation = CLLocation(latitude: -35.2802, longitude: 149.1310)
    let defaultLocationDistance: CLLocationDistance = 100
    var currentLocation: CLLocation?
    var locationManager: CLLocationManager?
    var isLocationAccessAllowed = false

    var movingSession = MovingSession()
    var lineOverlay: MKPolyline?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationUnit.shared.requestNotificationPermission()
        setUpLocationManager()
        setInitialLocationToMapView()
        startUpdatingLocation()
    }
    
    private func setUpLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 1
        locationManager?.activityType = .fitness
        switch locationManager?.authorizationStatus {
        case .restricted, .notDetermined, .denied:
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            centerMapView(to: locationManager?.location)
        default:
            break
        }
    }
    
    private func setInitialLocationToMapView() {
        var coordinateRegion = MKCoordinateRegion(center: defaultLocation.coordinate,
                                                  latitudinalMeters: defaultLocationDistance,
                                                  longitudinalMeters: defaultLocationDistance)
        if let currentLocation = currentLocation {
            coordinateRegion.center = currentLocation.coordinate
        }
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func startUpdatingLocation() {
        if isLocationAccessAllowed {
            locationManager?.startUpdatingLocation()
        }
    }
    
    private func centerMapView(to location: CLLocation?) {
        guard let location = location else {
            return
        }
        currentLocation = location
        isLocationAccessAllowed = true
        mapView.setCenter(location.coordinate, animated: true)
        os_log("Center mapview to user location")
    }
    
    private func updateView() {
        switch movingSession.state {
        case .idle:
            startPauseButton.setTitle("Start", for: .normal)
            speedLabel.text = "Start a new moving session"
        case .running:
            startPauseButton.setTitle("Finish", for: .normal)
            speedLabel.text = "Current speed \(movingSession.averageSpeed)m/s"
        }
    }
    
    /// Add a polyline through user previous locations
    private func updateLineOverlayOnMapView() {
        if let lineOverlay = lineOverlay {
            mapView.removeOverlay(lineOverlay)
        }
        let locationHistory = movingSession.locationHistory
        let coordinates = locationHistory.map { $0.location.coordinate }
        lineOverlay = MKPolyline(coordinates: coordinates, count: locationHistory.count)
        mapView.addOverlay(lineOverlay!)
    }

    @IBAction func startOrFinish() {
        guard let currentLocation = currentLocation else {
            return
        }
        switch movingSession.state {
        case .idle:
            movingSession.startLocation = currentLocation
            movingSession.start()
            os_log("Start a new moving session")
        case .running:
            self.currentLocation = locationManager?.location
            movingSession.finish(location: currentLocation)
            os_log("Finish current moving session")
            break
        }
        updateView()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            os_log("Location access has been authorised")
            centerMapView(to: manager.location)
        case .denied, .notDetermined, .restricted:
            os_log("User denied access to location.")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isLocationAccessAllowed {
            guard let lastLocation = locations.last, let currentLocation = currentLocation else {
                return
            }
            movingSession.saveLocationToHistory(location: lastLocation)
            updateView()
//            updateLineOverlayOnMapView()
            let distance = lastLocation.distance(from: currentLocation)
            if distance > 10 {
                textView.text += "\nYou have moved \(distance)m from your last location"
                self.currentLocation = lastLocation
                let annotation = MKPointAnnotation()
                annotation.coordinate = lastLocation.coordinate
                mapView.addAnnotation(annotation)
//                NotificationUnit.shared.showNotification(title: "Congratulation!", body: "You have moved \(distance)m from your last position")
            }
        }
    }

}
