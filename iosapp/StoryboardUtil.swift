//
//  StoryboardUtil.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/20/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    
    class func loginViewController() -> LoginViewController {
        return UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
    }
}
