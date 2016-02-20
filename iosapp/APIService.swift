//
//  APIService.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIService {
    static let sharedInstance = APIService()
    // block outside objects to create instances of API Service
    // That way, we can ensure the it will a singleton
    private init() {}
    
    func signInUser(email: String, password: String, completionHandler: (success: Bool) -> Void) {
        let json = ["email": email, "password": password]
        Alamofire.request(Router.signInUser(json)).responseJSON { (response) -> Void in
            guard response.result.error == nil else {
                print("Error calling \(Router.signInUser(json))")
                print("Error: \(response.result.error)")
                completionHandler(success: false)
                return
            }
            if let httpResponse = response.response {
                if 200...210 ~= httpResponse.statusCode{
                    let headers = httpResponse.allHeaderFields
                    let client = headers["Client"] as! String
                    let accessToken = headers["access-token"] as! String
                    let expiry = headers["expiry"] as! String
                    // Cache user data to send in further request headers
                    Router.AUTH_CLIENT = client
                    Router.AUTH_EXPIRY = expiry
                    Router.AUTH_TOKEN = accessToken
                    Router.AUTH_UID = email
                    completionHandler(success: true)
                }
            }
        }
    }
    
    func savePhoto(photo: Photo, completionHandler: (success: Bool, photo: Photo?) -> Void) {
        let json = photo.toJSON()
        Alamofire.request(Router.createPhoto(json)).responseObject { (response: Response<Photo, NSError>) -> Void in
            if response.result.error == nil {
                completionHandler(success: true, photo: response.result.value)
            }
        }
    }
    
    func loadPhotos(completionHandler: (success: Bool, photos: [Photo]?) -> Void) {
        Alamofire.request(Router.getPhotos).responseCollection { (response: Response<[Photo], NSError>) -> Void in
            guard response.result.error == nil else {
                print("Error calling \(Router.getPhotos)")
                print("Error: \(response.result.error)")
                completionHandler(success: false, photos: nil)
                return
            }
            
            if let httpResponse = response.response {
                if 200...210 ~= httpResponse.statusCode {
                    completionHandler(success: true, photos: response.result.value)
                }
                else if 400...499 ~= httpResponse.statusCode {
                    print("Loading photos error. Status: \(httpResponse.statusCode)")
                    completionHandler(success: false, photos: nil)
                }
            }
        }
    }
    
    class func userIsLoggedIn() -> Bool {
        guard (Router.AUTH_CLIENT != nil) else {
            return false
        }
        return true
    }
}