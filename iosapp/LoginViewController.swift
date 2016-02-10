//
//  LoginViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
    }
    
    @IBAction func newUser(sender: AnyObject) {
    }
    
    
}
