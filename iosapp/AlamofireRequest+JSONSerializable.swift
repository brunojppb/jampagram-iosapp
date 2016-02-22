//
//  AlamofireRequest+JSONSerializable.swift
//  iosapp
//
//  Created by Bruno Paulino on 2/10/16.
//  Copyright © 2016 brunopaulino. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension Alamofire.Request {
    
    public func responseObject<T: ResponseJSONObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let serializer = ResponseSerializer<T, NSError> {
            request, response, data, error in
            guard error == nil else {
                return .Failure(error!)
            }
            guard let responseData = data else {
                let failureReason = "Object could not be serialized because input data was nil"
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(error)
            }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, responseData, error)
            
            switch result {
            case .Success(let value):
                let json = SwiftyJSON.JSON(value)
                let jsonData = json["data"]
                if let object = T(json: jsonData) {
                    return .Success(object)
                }
                else {
                    let failureReason = "Object could not be created from JSON"
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
    
    public func responseCollection<T: ResponseJSONCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            guard let data = data else { return .Failure(error!) }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                let json = SwiftyJSON.JSON(value)
                if let objects: [T] = T.collection(json) {
                    return .Success(objects)
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
}
