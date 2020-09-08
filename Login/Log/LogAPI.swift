//
//  LogAPI.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//


import Foundation
import SwiftKeychainWrapper
protocol LogAPIProtocol {
     func register (name:String ,email:String , password:String , passwordConfirm:String , mobileToken:String,completion : @escaping (Result<BaseResponse<UserData>?,NSError>)-> Void )
    
    func login(email:String , password:String ,mobile_token:String ,completion : @escaping (Result<BaseResponse<UserData>?,NSError>)-> Void )
    
}




class LogAPI : BaseAPI <LogNetworking> , LogAPIProtocol {
  
    
    // MARK:- request
    // static let shared = LogAPI()
    
    func register(name:String ,email:String , password:String , passwordConfirm:String , mobileToken:String ,completion : @escaping (Result<BaseResponse<UserData>?,NSError>)-> Void ) {
        self.fetchData(target: .register(name: name
            , email: email
            , password: password
            , password_confirmation: passwordConfirm
            , mobile_token: mobileToken )
        , responseClass: BaseResponse<UserData>.self) { (result) in
           print(result)
            completion(result)
        }
    }
    
    func login(email:String , password:String ,mobile_token:String ,completion : @escaping (Result<BaseResponse<UserData>?,NSError>)-> Void ) {
        guard let retrievedTokenString: String = KeychainWrapper.standard.string(forKey: "accessToken") else{
            print("there is no access token stored yet")
            return}

        self.fetchData(target: .login(email: email
            , password: password
            , mobile_token : mobile_token
            , Authorization: retrievedTokenString)
        , responseClass: BaseResponse<UserData>.self) { (result) in
             print(result)
            completion(result)
        }
    }
}
