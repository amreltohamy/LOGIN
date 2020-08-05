//
//  BaseAPI.swift
//  Login
//
//  Created by MacBook on 8/4/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

//

/*
 هيكون فيها ال functions الاساسيه اللي هتعمل من خلالها ال networking
 
 */

import Foundation
import Alamofire

/*
 السطرين اللي تحت دول الصوره العامه لاي حد عاوز يبpass -> url
 1-- هتاخد target of type T ودا احنا هنعمله spicification لما نستخدم ال baseAPI
 */

class BaseAPI <T:TargetType> {
    func fetchData<M:Decodable>(target: T , responseClass : M.Type , compilation : @escaping (Result<M?,NSError>)->Void){
        
        // configure the parameters
        let method = Alamofire.HTTPMethod(rawValue: target.methodes.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let parameters =  buildParameters(task: target.task)
        
        // starting the task
        AF.request(target.baseURL + target.path , method: method , parameters: parameters.0 ,encoding: parameters.1 , headers: headers).responseJSON { (response) in
          //  print(response)
            guard let statusCode = response.response?.statusCode
                else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey : ErrorMessage.genericError])
                    compilation(.failure(error))
                return}
            
            
            if statusCode == 200 {
                
                // succcessfull request
                guard let jsonResponse =  try? response.result.get()
                    else{
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey : ErrorMessage.genericError])
                        compilation(.failure(error))
                        return}
            //    print("jsonResponse -->> \(jsonResponse)")
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: [])
                    else {
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey : ErrorMessage.genericError])
                        compilation(.failure(error))
                        return}
            //  print("jsonData -->> \(jsonData)")
                guard let response = try? JSONDecoder().decode(M.self ,from: jsonData)
                    else {
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey : ErrorMessage.genericError])
                        compilation(.failure(error))
                        return}
                print("response in BaseAPI --->> \(response)")
                compilation(.success(response))
                
            }else {
                let message = "message parsed from backend"
               let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey : message])
                compilation(.failure(error))
                
            }
            
        }
    }
    
    
    
    
    private func buildParameters (task:Task)->([String:Any],ParameterEncoding){
        switch task {
            
        case .requestPlain:
            return([:],URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return(parameters,encoding)
        }
    }
}
