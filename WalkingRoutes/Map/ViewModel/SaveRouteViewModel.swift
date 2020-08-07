//
//  SaveRouteViewModel.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation

struct SaveRouteViewModel {

  let route: RouteModel
  let distance:String
  let time: String
  var name: String?
  
  init(route: RouteModel) {
    self.route = route
    distance = "\(route.distance) km"
    time = "\(route.time)"
  }
  
  func saveRoute() {
      do {
        try CoreDataManager.shared.insertRoute(name: name ?? "",
                                               distance: route.distance,
                                               time: route.time)
      } catch let error {
        print(error.localizedDescription)
      }
  }
  
}
