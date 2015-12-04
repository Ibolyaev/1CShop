//
//  User.swift
//  1CShop
//
//  Created by Ronin bol on 25/11/15.
//  Copyright © 2015 rightway. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import SwiftyJSON
import Foundation

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: JSON)
}

public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse, representation: JSON) -> [Self]
}


final class User: ResponseObjectSerializable {
    let username: String
    let name: String
    
    init?(response: NSHTTPURLResponse, representation: JSON) {
        response.URL?.description
        self.username = response.URL!.lastPathComponent!
        self.name = representation["name"].stringValue
    }
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                let json = JSON(value)
                
                if let response = response {
                    return .Success(T.collection(response: response, representation: json))
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

extension Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                let json = JSON(value)
                
                if let
                    response = response,
                    responseObject = T(response: response, representation: json)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
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