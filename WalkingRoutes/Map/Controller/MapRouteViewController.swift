//
//  MapRouteViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapRouteViewControllerDelegate: class {
  func finishButtonTapped(with route: RouteModel)
  func showErrorMessage(_ message: String)
}


enum WalkState: String {
  case start = "Start"
  case end = "Finish"
}

class MapRouteViewController: UIViewController {
  
  weak var delegate: MapRouteViewControllerDelegate?
  @IBOutlet private var mapView: GMSMapView!
  var viewModel:MapRouteViewModel!
  private var userMarker = GMSMarker()
  private var startMarker = GMSMarker()
  private var endMarker = GMSMarker()
  let path = GMSMutablePath()
  let polyline = GMSPolyline()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = MapRouteViewModel()
    viewModel.delegate = self
  }
  
  //MARK: - Events
  
  @IBAction func startEndTapped(_ sender: UIButton) {
    switch viewModel.walkState {
    case .start:
      path.removeAllCoordinates()
      mapView.clear()
      configureRouteMarkers()
      viewModel.startWalk { [weak self] coordinate in
        guard self != nil else { return }
        self?.startMarker.position = coordinate
      }
      sender.setTitle(viewModel.walkState.rawValue, for: .normal)
    case .end:
      viewModel.endWalk { [weak self] coordinate in
        guard self != nil else { return }
        self?.endMarker.position = coordinate
      }
      sender.setTitle(viewModel.walkState.rawValue, for: .normal)
      let route = RouteModel(distance: viewModel.distanceFormatted,
                             time: viewModel.timeFormatted)
      delegate?.finishButtonTapped(with: route)
    }
  }
  
  //MARK: - Map draw
  
  func drawLine(_ location: CLLocation) {
    path.addLatitude(location.coordinate.latitude, longitude: location.coordinate.longitude)
    polyline.path = path
    polyline.strokeWidth = 10.0
    polyline.geodesic = true
    polyline.map = mapView
  }
  
  func configureRouteMarkers() {
    userMarker.icon = UIImage(named:"person-walking")
    userMarker.map = mapView
    userMarker.setIconSize(scaledToSize: CGSize(width: 30, height: 30))
    startMarker.icon = UIImage(named:"start")
    startMarker.setIconSize(scaledToSize: CGSize(width: 40, height: 30))
    startMarker.map = mapView
    endMarker.icon = UIImage(named:"finish")
    endMarker.map = mapView
    endMarker.setIconSize(scaledToSize: CGSize(width: 40, height: 30))
  }

  
}

extension MapRouteViewController: MapRouteViewModelDelegate {
  func permissionError() {
    self.delegate?.showErrorMessage("Enable location services from your app settings.")
  }
  
  func locationError() {
    self.delegate?.showErrorMessage("An error has ocurred.")
  }
  
  func startedWalking(_ location: CLLocation) {
    let camera =  GMSCameraPosition(
      target: location.coordinate,
      zoom: 20,
      bearing: 0,
      viewingAngle: 0)
    mapView.camera = camera
    userMarker.position = location.coordinate
    drawLine(location)
  }
  
}


