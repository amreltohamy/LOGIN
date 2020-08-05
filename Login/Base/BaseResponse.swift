//
//  BaseResponse.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation

class BaseResponse<T:Codable> :Codable {
    var token:String
    var user :T?
    
}
