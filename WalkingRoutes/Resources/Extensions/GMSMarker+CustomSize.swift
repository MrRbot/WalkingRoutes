//
//  GMSMarker+CustomSize.swift
//  WalkingRoutes
//
//  Created by Javier on 07/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import UIKit
import GoogleMaps

extension GMSMarker {
    func setIconSize(scaledToSize newSize: CGSize) {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        icon?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        icon = newImage
    }
}
