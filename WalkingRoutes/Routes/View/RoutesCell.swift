//
//  RoutesCell.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

class RoutesCell: UITableViewCell {

  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var distanceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
    
  func configCell(route: Route) {
    self.nameLabel.text = "Name: \(route.name ?? "")"
    self.distanceLabel.text = "Distance: \(route.distance)"
  }
}
