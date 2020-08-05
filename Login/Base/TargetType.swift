//
//  TargetType.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethode : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
enum Task {
    case requestPlain
    case requestParameters(parameters:[String:Any],encoding:ParameterEncoding)
    
}
protocol TargetType {

    var baseURL : String { get }
    var path : String {get}
    var methodes : HTTPMethod {get}
    var task : Task {get}
    var headers : [String:String]?{get}
}
