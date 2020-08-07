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
  var routesViewController: RoutesTableViewController!
  var routesDetailViewController: RoutesDetailViewController!
  var saveRouteViewController: SaveRouteViewController!
  
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
    routesViewController = RoutesTableViewController()
    routesViewController.delegate = self
    routesViewController.tabBarItem = UITabBarItem(title: "Routes", image: nil, selectedImage: nil)
    routesViewController.tabBarItem.tag = 1
    routesDetailViewController = RoutesDetailViewController()
    routesDetailViewController.delegate = self
    saveRouteViewController = SaveRouteViewController()
    saveRouteViewController.delegate = self

  }
  
  private func displayAlert(for message: String) {
    
    let alert = UIAlertController(title: nil,
                                  message: message,
                                  preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK",
                                  style: .default,
                                  handler: nil))
    
    alert.show()
  }

  
}

extension CoordinatorViewController: MapRouteViewControllerDelegate {
  
  func finishButtonTapped(with route: RouteModel) {
    // Injection of the SaveRouteViewModel.
    let viewModel = SaveRouteViewModel(route: route)
    saveRouteViewController.viewModel = viewModel
    self.present(saveRouteViewController, animated: true, completion: nil)
  }
  
  func showErrorMessage(_ message: String) {
    self.displayAlert(for: message)
  }
  
}

extension CoordinatorViewController: SaveRouteViewControllerDelegate {
  
  func showError(_ message: String) {
    self.displayAlert(for: message)
  }
  
  func saveTapped() {
    routesViewController.viewModel.getRoutes()
    routesViewController.tableView.reloadData()
    self.dismiss(animated: true, completion: nil)
  }
  
}

extension CoordinatorViewController: RoutesTableViewControllerDelegate {
  
  func didSelectRow(with route: Route) {
    routesDetailViewController.route = route
    self.present(routesDetailViewController, animated: true, completion: nil)
  }
  
}

extension CoordinatorViewController: RoutesDetailViewControllerDelegate {
  
  func deleteTapped() {
    self.routesDetailViewController.dismiss(animated: true) {
      self.routesViewController.viewModel.getRoutes()
      self.routesViewController.tableView.reloadData()
    }
  }

  func shareTapped(shareContent: String) {
    let items = [shareContent]
    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
    routesDetailViewController.present(ac, animated: true, completion: nil)
  }
  
  func dismissTapped() {
    self.dismiss(animated: true, completion: nil)
  }
  
}


private extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1 
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}


