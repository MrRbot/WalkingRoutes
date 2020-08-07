//
//  RoutesDetailViewModel.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation

struct RoutesDetailViewModel {
  
  let name: String
  let distance: String
  let time: String
  let shareContent: String
  
  init(name: String?, distance: Double, time: String?) {
    self.name = name ?? ""
    self.distance = "\(distance) km"
    self.time = "\(time ?? "")"
    self.shareContent = "Hey, I traveled: \(self.distance) in: \(self.time)"
  }
  
}
