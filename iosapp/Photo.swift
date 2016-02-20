//
//  Photo.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import SwiftyJSON

final class Photo : ResponseJSONObjectSerializable, ResponseJSONCollectionSerializable, CustomStringConvertible {
    var id:Int?
    var title:String?
    var imageUrl:String?
    
    init(title: String, imageURL: String) {
        self.title = title
        self.imageUrl = imageURL
    }
    
    required init?(json: SwiftyJSON.JSON) {
        print("data: \(json)")
        self.id = Int(json["id"].string!)
        self.title = json["attributes"]["title"].string
        self.imageUrl = json["attributes"]["image_url"].string
        print("Photo: \(self)")
    }
    
    static func collection(json: SwiftyJSON.JSON) -> [Photo] {
        var photos: [Photo] = []
        if let photosAsJSON = json["data"].array {
            for photoJSON in photosAsJSON {
                if let photo = Photo(json: photoJSON) {
                    photos.append(photo)
                }
            }
        }
        return photos
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
    
    var description: String {
        return "id: \(self.id)\nTitle: \(self.title)\nImage URL: \(self.imageUrl)"
    }
    
}