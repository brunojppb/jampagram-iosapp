//
//  LoginViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

protocol LoadPhotosDelegate {
    func didLoginWithSuccess() -> Void
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    var delegate : LoadPhotosDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
        APIService.sharedInstance.signInUser(inputEmail.text!, password: inputPassword.text!) { (success) -> Void in
            if success {
                //TODO: remove login screen. show main view
                print("Login success")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.delegate?.didLoginWithSuccess()
                })
            } else {
                print("Login error")
                //TODO: Show error message
                
            }
        }
    }
    
    @IBAction func newUser(sender: AnyObject) {
        
    }
    
    
}
