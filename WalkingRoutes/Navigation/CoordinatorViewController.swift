//
//  CoordinatorViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

class CoordinatorViewController: UIViewController {
  
  var navController: UINavigationController!
  var mapViewController: MapRouteViewController!
  var routesViewController: RoutesViewController!
  var routesDetailViewController: RoutesDetailViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    createViewControllers()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let tabBarController = TabBarController()
    tabBarController.viewControllers = [mapViewController, routesViewController]
    navController = UINavigationController(rootViewController: tabBarController)
    self.presentVC(navController)
  }
  
  func createViewControllers() {
    mapViewController = MapRouteViewController()
    mapViewController.tabBarItem = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
    mapViewController.tabBarItem.tag = 0
    mapViewController.delegate = self
    routesViewController = RoutesViewController()
    routesViewController.tabBarItem = UITabBarItem(title: "Routes", image: nil, selectedImage: nil)
    routesViewController.tabBarItem.tag = 1
    routesDetailViewController = RoutesDetailViewController()

  }
  
  private func displayAlert(for message: String) {
    
    let alert = UIAlertController(title: nil,
                                  message: message,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK",
                                  style: .default,
                                  handler: nil))
    
    present(alert, animated: true, completion: nil)
  }

  
}

extension CoordinatorViewController: MapRouteViewControllerDelegate {
  
  func createRouteButtonTapped() {
    
  }
  
}
