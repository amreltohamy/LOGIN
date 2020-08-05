//
//  LogNetworking.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import Alamofire


enum LogNetworking {
    
    case login (email:String , password:String , mobileToken :String , Authorization :String)
    case register(name:String ,email:String , password:String , password_confirmation :String , mobile_token :String )
      
}



extension LogNetworking : TargetType {
  
    
    var baseURL: String {
        switch self {
        case .login :
            return "https://www.hatly.be4maps.com/api/auth"
        case .register :
            return "https://www.hatly.be4maps.com/api/auth"
        }
    }
    
    var path: String {
        switch self {
            
        case .login:
            return "/login"
        
        case .register:
            return "/register"
        }
    }
    
    var methodes: HTTPMethod {
        switch self {
            
        case .login:
            return .post
        case .register:
            return .post
        }
    }
    
    var task: Task {
        switch self {
            
        case .login ( email:let email
            ,password:let password
            ,mobileToken : let mobileToken
            ,Authorization: _ ):
            return .requestParameters(parameters: ["email": email,
                                                   "password": password,
                                                   "mobile_token": mobileToken], encoding: JSONEncoding.default)
            
            
            
        case .register(name:let name
            ,email:let email
            ,password:let password
            ,password_confirmation :let passwordConfirm
            ,mobile_token :let mobileToken):
            
            return .requestParameters(parameters: [ "name":name,
                                                    "email":email,
                                                    "password":password,
                                                    "password_confirmation":passwordConfirm,
                                                    "mobile_token":mobileToken],
                                      encoding: JSONEncoding.default)
            
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .login ( email:_
        ,password:_
        ,mobileToken : _
        ,Authorization: let bearer ):
            return ["Content-Type":"application/json" , "Authorization" : bearer]
        case .register :
            return ["Content-Type":"application/json"]
            
        }
    }
    
    
}
