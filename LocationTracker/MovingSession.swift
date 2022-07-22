//
//  MovingSession.swift
//  LocationTracker
//
//  Created by Long Nguyen on 22/7/2022.
//

import Foundation
import CoreLocation

enum MovingSessionState {
    case running
    case idle
}

class MovingSession {
    var startLocation: CLLocation
    var locationHistory = [LocationAndTime]()
    var averageSpeed: Double = 0
    var startTime: Double = 0
    var state: MovingSessionState = .idle
    
    init() {
        self.startLocation = CLLocation()
    }

    init(startLocation: CLLocation) {
        self.startLocation = startLocation
    }
    
    func start() {
        startTime = Date().timeIntervalSince1970
        locationHistory.append(LocationAndTime(location: startLocation, timestamp: startTime, distanceFromLastLocation: 0))
        state = .running
    }
    
    func saveLocationToHistory(location: CLLocation) {
        guard let lastLocation = locationHistory.last else { return }
        let distanceFromLastLocation = lastLocation.location.distance(from: startLocation)
        let saveTime = Date().timeIntervalSince1970
        let newLocation = LocationAndTime(location: location,
                                          timestamp: saveTime,
                                          distanceFromLastLocation: distanceFromLastLocation)
        self.locationHistory.append(newLocation)
        updateAverageSpeed()
    }
    
    func updateAverageSpeed() {
        guard !locationHistory.isEmpty else { return }
        let distanceAndTimeTravelled = locationHistory.map {$0.distanceAndTime}
        averageSpeed = DistanceAndTime.calculateAverageSpeed(distanceAndTime: distanceAndTimeTravelled)
    }
    
    func finish(location: CLLocation) {
        saveLocationToHistory(location: location)
        state = .idle
    }
}

struct LocationAndTime {
    let location: CLLocation
    let timestamp: Double
    let distanceFromLastLocation: Double
    var distanceAndTime: DistanceAndTime {
        return DistanceAndTime(distance: distanceFromLastLocation, time: timestamp)
    }
}

struct DistanceAndTime: Equatable {
    let distance: Double
    let time: Double
    
    static func calculateAverageSpeed(distanceAndTime: [DistanceAndTime]) -> Double {
        let totalDistanceTravelled = distanceAndTime.map {$0.distance}.reduce(0, +)
        guard let first = distanceAndTime.first, let last = distanceAndTime.last, first.time != last.time else {
            return 0.0
        }
        let timeElapsed = last.time - first.time
        return totalDistanceTravelled / timeElapsed
    }
}
