//
//  SignupViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/27/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signup(sender: AnyObject) {
        self.loadingSpinner.hidden = false
        self.loadingSpinner.startAnimating()
        self.confirmPasswordTextField.becomeFirstResponder()
        self.confirmPasswordTextField.resignFirstResponder()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let passwordConfirmation = confirmPasswordTextField.text!
        APIService.sharedInstance.signupUser(email, password: password, passwordConfirmation: passwordConfirmation) { (success) -> Void in
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "Signup Error", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            self.loadingSpinner.stopAnimating()
        }
    }
    
}
