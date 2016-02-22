//
//  NewPhotoViewController.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/20/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit

class NewPhotoViewController: UIViewController {
    
    var imagePicker: UIImagePickerController!
    var imageTaken: UIImage?
    
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBAction func discardPhoto(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func sendPhoto(sender: AnyObject) {
        self.savePhoto()
    }
    
    @IBAction func takePhoto(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                self.imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func savePhoto() {
        if let image = self.imageTaken {
            let imageData = UIImageJPEGRepresentation(image, 0.9)
            let base64ImageString = imageData?.base64EncodedStringWithOptions(.EncodingEndLineWithLineFeed)
            let photo = Photo(title: self.titleTextField.text, imageURL: nil, imageDataString: base64ImageString)
            APIService.sharedInstance.savePhoto(photo, completionHandler: { (success, photo) -> Void in
                if success {
                    print("image saved")
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }
    }
    
}

extension NewPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageTaken = image
        self.takePhotoButton.setBackgroundImage(image, forState: .Normal)
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
