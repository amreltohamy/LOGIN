//
//  LoginViewController.swift
//  Login
//
//  Created by MacBook on 9/8/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    var email : String?
    var password : String?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    }
    

   
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        email = emailTextField.text
        
        password = passwordTextField.text
         guard let devToken = UIDevice.current.identifierForVendor?.uuidString else{return}
        print(devToken)
        
        print("hello... from login ... starting lo in now ....")
        
        let api : LogAPIProtocol = LogAPI()
        print("hello in my api")
        api.login(
            email: email!,
            password: password!
            ,mobile_token: devToken){ (result) in
                
          switch result {
            case .success(let response):
                print("login sucess...response is..")
                print(response ?? "there is no resonse catched")
                //TODO:- dismiss viewcontroller
                
            case .failure(let error):
                print(error.localizedDescription)
                print("something went wrong")
                //TODO:- show users errors in there paramters
                
                
            }
        }
    }
    
}
