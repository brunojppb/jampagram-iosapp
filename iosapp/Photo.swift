//
//  Photo.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

class Photo {
    var id:Int?
    var title:String?
    var imageUrl:String?
    
    init(json: [String:AnyObject]) {
        self.fillWithJSON(json)
    }
    
    func fillWithJSON(dict:[String:AnyObject]) {
        if let id = dict["id"] as? Int {
            self.id = id
        }
        if let title = dict["title"] as? String {
            self.title = title
        }
        if let imageUrl = dict["image_url"] as? String {
            self.imageUrl = imageUrl
        }
    }
    
    func toJSON() -> [String:AnyObject] {
        var json = [String:AnyObject]()
        if let id = self.id { json["id"] = id }
        if let title = self.title { json["title"] = title }
        if let imageUrl = self.imageUrl { json["image_url"] = imageUrl }
        var photo = [String:AnyObject]()
        photo["photo"] = json
        return photo
    }
    
}