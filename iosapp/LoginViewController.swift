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
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    var delegate : LoadPhotosDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(sender: AnyObject) {
        self.loadingSpinner.hidden = false
        self.loadingSpinner.startAnimating()
        inputEmail.becomeFirstResponder()
        inputEmail.resignFirstResponder()
        APIService.sharedInstance.signInUser(inputEmail.text!, password: inputPassword.text!) { (success) -> Void in
            if success {
                //TODO: remove login screen. show main view
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.delegate?.didLoginWithSuccess()
                })
            } else {
                let alertController = UIAlertController(title: "Sign in Error", message: "", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
            self.loadingSpinner.stopAnimating()
        }
    }
    
    @IBAction func newUser(sender: AnyObject) {
        
    }
    
    
}
