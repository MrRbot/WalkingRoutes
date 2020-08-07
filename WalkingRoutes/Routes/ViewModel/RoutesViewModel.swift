//
//  RoutesViewModel.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation

struct RoutesViewModel {
  
  var routes = [Route]()
  
  init() {
    getRoutes()
  }
  mutating func getRoutes() {
    do {
      self.routes = try CoreDataManager.shared.fetchRoutes()
    } catch _ { }
  }
  
}
