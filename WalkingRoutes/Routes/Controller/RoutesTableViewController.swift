//
//  RoutesTableViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

protocol RoutesTableViewControllerDelegate: class {
  func didSelectRow(with route: Route)
}

class RoutesTableViewController: UITableViewController {
  
  lazy var viewModel = RoutesViewModel()
  let CELLID = "RoutesCell"
  weak var delegate: RoutesTableViewControllerDelegate?
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: CELLID, bundle: nil), forCellReuseIdentifier: CELLID)
  }
  
}

// Mark: -  Delegate and Datasource

extension RoutesTableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.routes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CELLID,
                                                   for: indexPath) as? RoutesCell
                                                   else { return  UITableViewCell() }
    cell.configCell(route: viewModel.routes[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80.0
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    print(viewModel.routes[indexPath.row])
    delegate?.didSelectRow(with: viewModel.routes[indexPath.row])
  }
  
}


