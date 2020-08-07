//
//  MapRouteViewModel.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol MapRouteViewModelDelegate: class {
  func locationError()
  func permissionError()
  func startedWalking(_ location: CLLocation)
}

typealias completionWithCoordinate = (_ coordinate: CLLocationCoordinate2D)->()

class MapRouteViewModel: NSObject {
  
  private var seconds = 0
  private var timer: Timer?
  private var distance = Measurement(value: 0, unit: UnitLength.meters)
  private var locationList: [CLLocation] = []
  var walkState = WalkState.start
  var locationManager = CLLocationManager()
  weak var delegate: MapRouteViewModelDelegate?
  public var timeFormatted = ""
  public var distanceFormatted = 0.0
  
  func startWalk(completion: completionWithCoordinate) {
    seconds = 0
    distance = Measurement(value: 0, unit: UnitLength.kilometers)
    locationList.removeAll()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
      self.eachSecond()
    }
    startLocationUpdates()
    guard let coordinate = locationManager.location?.coordinate else {
      self.delegate?.locationError()
      return
    }
    walkState = .end
    completion(coordinate)
    
  }
  
  func endWalk(completion: completionWithCoordinate) {
    locationManager.stopUpdatingLocation()
    guard let coordinate = locationManager.location?.coordinate else {
      self.delegate?.locationError()
      return
    }
    walkState = .start
    distanceFormatted = distance.value.toKm()
    timeFormatted = seconds.toTimeString()
    completion(coordinate)
  }
  
  func eachSecond() {
    seconds += 1
  }
  
  private func startLocationUpdates() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.delegate = self
    locationManager.activityType = .fitness
    locationManager.distanceFilter = 10
    locationManager.startUpdatingLocation()
  }
}

extension MapRouteViewModel: CLLocationManagerDelegate {
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    guard status == .authorizedWhenInUse else {
      self.delegate?.permissionError()
      return
    }
    
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    if walkState == .end {
      delegate?.startedWalking(location)
    }
    
    for newLocation in locations {
      let howRecent = newLocation.timestamp.timeIntervalSinceNow
      guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

      if let lastLocation = locationList.last {
        let delta = newLocation.distance(from: lastLocation)
        distance = distance + Measurement(value: delta, unit: UnitLength.kilometers)
      }
      locationList.append(newLocation)
    }

  }

  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print(error.localizedDescription)
  }
  
}




