//
//  ViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/9/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController, LoadPhotosDelegate {
    
    var dataSource = [1,2,3,4,5,6]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if !APIService.userIsLoggedIn() {
            let loginViewController = UIStoryboard.loginViewController()
            loginViewController.delegate = self
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell")
        return cell!
    }
    
    func didLoginWithSuccess() -> Void {
        print("loading photos")
        APIService.sharedInstance.loadPhotos { (success, photos) -> Void in
            print("Success: \(success)")
            let photo = photos![0]
            print("Photo: \(photo.imageUrl)")
        }
    }
}

