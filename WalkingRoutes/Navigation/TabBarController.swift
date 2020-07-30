//
//  TabBarController.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
    self.title = "Walk Route"
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    switch item.tag {
      case 0:
        self.title = "Walk Route"
      case 1 :
        self.title = "Routes List"
      default:
        break
    }
  }
  
   // MARK: - Navigation


}
