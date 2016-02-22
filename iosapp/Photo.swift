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
    var imageDataString:String?
    
    init(title: String?, imageURL: String?, imageDataString: String?) {
        self.title = title
        self.imageUrl = imageURL
        self.imageDataString = imageDataString
    }
    
    required init?(json: SwiftyJSON.JSON) {
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
        var data = [String:AnyObject]()
        var imageFileData = [String: AnyObject]()
        if let title = self.title { json["title"] = title }
        if let imageDataString = self.imageDataString {
            imageFileData["file"] = imageDataString
            imageFileData["extension"] = "jpg"
            imageFileData["content_type"] = "image/jpg"
        }
        json["image_file"] = imageFileData
        data["data"] = ["attributes": json]
        return data
    }
    
    var description: String {
        return "id: \(self.id)\nTitle: \(self.title)\nImage URL: \(self.imageUrl)"
    }
    
}