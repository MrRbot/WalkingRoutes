//
//  RoutesDetailViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

protocol RoutesDetailViewControllerDelegate: class {
  func deleteTapped()
  func shareTapped(shareContent: String)
  func dismissTapped()
}

class RoutesDetailViewController: UIViewController {

  @IBOutlet private var routeLabel: UILabel!
  @IBOutlet private var distanceLabel: UILabel!
  @IBOutlet private var timeLabel: UILabel!
  weak var delegate: RoutesDetailViewControllerDelegate?
  var viewModel: RoutesDetailViewModel!
  
  //MARK: - Injections
  
  var route: Route!
  
  //MARK: - Life cycle
  
  override func viewWillAppear(_ animated: Bool) {
    viewModel = RoutesDetailViewModel(name: route.name,
                                      distance: route.distance,
                                      time: route.time)
    routeLabel.text = viewModel.name
    distanceLabel.text = viewModel.distance
    timeLabel.text = viewModel.time
  }
  
  //MARK: - Events
  
  @IBAction func deletePressed(_ sender: UIButton) {
    CoreDataManager.shared.delete(route: self.route)
    delegate?.deleteTapped()
  }
  
  @IBAction func dismissPressed(_ sender: UIButton) {
    delegate?.dismissTapped()
  }
  
  @IBAction func sharePressed(_ sender: UIButton) {
    delegate?.shareTapped(shareContent: viewModel.shareContent)
  }
  

}
