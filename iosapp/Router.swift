//
//  Router.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let BASE_URL = "http://192.168.1.104:3000"
    static var AUTH_TOKEN: String?
    static var AUTH_CLIENT: String?
    static var AUTH_EXPIRY: String?
    static var AUTH_UID: String?
    
    case signInUser([String:AnyObject])
    case signUpUser([String:AnyObject])
    case signOutUser(String)
    case getPhotos
    case createPhoto([String:AnyObject])
    case destroyPhoto(String)
    
    var method: Alamofire.Method {
        switch self {
        case .signInUser:
            return .POST
        case .signUpUser:
            return .POST
        case .signOutUser:
            return .DELETE
        case .getPhotos:
            return .GET
        case .createPhoto:
            return .POST
        case .destroyPhoto:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .signInUser:
            return "/api/v1/auth/sign_in"
        case .signUpUser:
            return "/api/v1/auth"
        case .signOutUser(let userId):
            return "/api/v1/auth/\(userId)"
        case .getPhotos:
            return "/api/v1/photos"
        case .createPhoto:
            return "/api/v1/photos"
        case .destroyPhoto(let photoId):
            return "/api/v1/photos/\(photoId)"
        }
    }
    
    // MARK: URLRequestConvertible protocol
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.BASE_URL)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Router.AUTH_TOKEN,
            let client = Router.AUTH_CLIENT,
            let expiry = Router.AUTH_EXPIRY,
            let uid = Router.AUTH_UID {
                mutableURLRequest.setValue(token, forHTTPHeaderField: "access-token")
                mutableURLRequest.setValue(client, forHTTPHeaderField: "Client")
                mutableURLRequest.setValue(expiry, forHTTPHeaderField: "expiry")
                mutableURLRequest.setValue(uid, forHTTPHeaderField: "uid")
            
        }
        
        switch self {
        case .signInUser(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        case .signUpUser(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        case .createPhoto(let params):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: params).0
        case .getPhotos:
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: nil).0
        default:
            return mutableURLRequest
        }
        
    }
    
}



















