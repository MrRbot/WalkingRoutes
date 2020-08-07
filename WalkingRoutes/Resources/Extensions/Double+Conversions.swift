//
//  Double+Conversions.swift
//  WalkingRoutes
//
//  Created by Javier on 07/08/20.
//  Copyright © 2020 MrRobot. All rights reserved.
//

import Foundation


extension Double {
  
  func toKm() -> Double {
    return (floor((self * 100)/100) / 1000)
  }
  
}

extension Int {
  
  func toTimeString() -> String {
    let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)

    let h_string = h < 10 ? "0\(h)" : "\(h)"
    let m_string =  m < 10 ? "0\(m)" : "\(m)"
    let s_string =  s < 10 ? "0\(s)" : "\(s)"

    return "\(h_string):\(m_string):\(s_string)"
  }
  
}
