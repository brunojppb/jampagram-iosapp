//
//  ViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/9/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController, LoadPhotosDelegate {
    
    var dataSource = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if !APIService.userIsLoggedIn() {
            let loginViewController = UIStoryboard.loginViewController()
            loginViewController.delegate = self
            self.presentViewController(loginViewController, animated: false, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let photo = self.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as! PhotoCell
        cell.configureCellForPhoto(photo)
        return cell
    }
    
    func didLoginWithSuccess() -> Void {
        print("loading photos")
        APIService.sharedInstance.loadPhotos { (success, photos) -> Void in
            print("Success: \(success)")
            self.dataSource = photos!
            self.tableView.reloadData()
        }
    }
}

