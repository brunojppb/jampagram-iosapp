//
//  PhotoCell.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/20/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import UIKit
import WebImage

class PhotoCell: UITableViewCell {
    
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoTitle: UILabel!
    
    func configureImageForCell(url: String) {
        self.photoImage.layer.cornerRadius = 5
        let imageURL = NSURL(string: "\(Router.BASE_URL)/\(url)")
        self.photoImage.sd_setImageWithURL(imageURL)
    }
}
