//
//  MapRouteViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

protocol MapRouteViewControllerDelegate: class {
  func createRouteButtonTapped()
}

class MapRouteViewController: UIViewController {
  
  weak var delegate: MapRouteViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
