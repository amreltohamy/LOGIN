//
//  LoginModel.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation

struct LoginModel : Codable {
    
}
struct UserData : Codable {
    let id : Int?
    let user_type_id : Int?
    let code :String?
    let name :String?
    let email :String?
    let gender :String?
    let address :String?
    let image_id :String?
    let phone :String?
    let email_verified_at :String?
    let mobile_token :String?
    let deleted_at :String?
    let created_at :String?
    let updated_at :String?
    
}
struct RegisterModel : Codable{
    let token : String
    let user : UserData
}
