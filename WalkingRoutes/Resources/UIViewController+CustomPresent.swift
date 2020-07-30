//
//  UIViewController+CustomPresent.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit

extension UIViewController {
  func presentVC(_ viewController: UIViewController) {
    transition(to: viewController)
  }
  
  func transition(to child: UIViewController, completion: ((Bool) -> Void)? = nil) {
    let duration = 0.3
    addChild(child)
    
    let newView = child.view!
    newView.translatesAutoresizingMaskIntoConstraints = true
    newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    newView.frame = view.bounds

    view.addSubview(newView)
    UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: { }, completion: { done in
      child.didMove(toParent: self)
      completion?(done)
    })
  }
}
