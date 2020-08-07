//
//  SaveRouteViewController.swift
//  WalkingRoutes
//
//  Created by Javier on 06/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

protocol SaveRouteViewControllerDelegate: class {
  func saveTapped()
  func showError(_ message: String)
  func dismissTapped()
}

class SaveRouteViewController: UIViewController {
  
  @IBOutlet private var timeLabel: UILabel!
  @IBOutlet private var distanceLabel: UILabel!
  
  @IBOutlet private var nameTextField: UITextField!
  
  //MARK: - Injections
  
  weak var delegate: SaveRouteViewControllerDelegate?
  var viewModel: SaveRouteViewModel!
  
  //MARK: - Life cycle
  
  override func viewWillAppear(_ animated: Bool) {
    nameTextField.delegate = self
    timeLabel.text = viewModel.time
    distanceLabel.text = viewModel.distance
  }
  
  // MARK: - Events
  
  @IBAction func saveTapped(_ sender: UIButton) {
    guard  !nameTextField.text!.isEmpty
      else { delegate?.showError("You have to enter a name"); return }
    viewModel.name = nameTextField.text!
    viewModel.saveRoute()
    delegate?.saveTapped()
  }
  
  @IBAction func dismissTapped(_ sender: UIButton) {
    delegate?.dismissTapped()
  }
  
  
}

// MARK: - TextField delegate

extension SaveRouteViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.nameTextField.resignFirstResponder()
    return true
  }
  
}
