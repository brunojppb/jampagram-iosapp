//
//  UICollorExtensions.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/22/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func colorWithRGB(red: Double, green: Double, blue: Double, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(alpha))
    }
    
}