//
//  AppDelegate.swift
//  WalkingRoutes
//
//  Created by Javier on 29/07/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    window = UIWindow(frame: UIScreen.main.bounds)
    let coordinatorVC = CoordinatorViewController()
    window?.rootViewController = coordinatorVC
    window?.makeKeyAndVisible()
    
    GMSServices.provideAPIKey("AIzaSyCizf176UFGUd_1WMOi1TDla6s-p925Ndc")
  }

  
}

