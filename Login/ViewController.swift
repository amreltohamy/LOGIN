//
//  ViewController.swift
//  Login
//
//  Created by MacBook on 8/3/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
   
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var UserEmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // configuring layouts
        
        userNameView.layer.cornerRadius = 22
        emailView.layer.cornerRadius = 22
        passwordView.layer.cornerRadius = 22
        confirmPasswordView.layer.cornerRadius = 22
        
        
        
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "enter your name",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        UserEmailTextField.attributedPlaceholder = NSAttributedString(string: "enter your email address",
                                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        PasswordTextField.attributedPlaceholder = NSAttributedString(string: "enter your password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordConfirmationTextField.attributedPlaceholder = NSAttributedString(string: "confirm your password",
                                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        signupButton.layer.cornerRadius = 22
        
    }
    
    
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        userNameView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 0)
        userNameView.layer.borderWidth = 1
        emailView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 0)
        emailView.layer.borderWidth = 1
        passwordView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 0)
        passwordView.layer.borderWidth = 1
        confirmPasswordView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 0)
        confirmPasswordView.layer.borderWidth = 1
        print("hello ....")
        
        // chick locally the validity of signup parameters
        
        
        guard let name = userNameTextField.text ,userNameTextField.text != "" else{
            userNameView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
            userNameView.layer.borderWidth = 4
            print("empty userNameView")
            return
        }
        
        guard let email = UserEmailTextField.text ,UserEmailTextField.text != "" else{
            emailView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
            emailView.layer.borderWidth = 4
            print("empty UserEmailTextField")
            return
        }
        
        guard let password = PasswordTextField.text ,PasswordTextField.text != "" else{
            passwordView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
            passwordView.layer.borderWidth = 4
            print("empty PasswordTextField")
            return
        }
        
        guard let passwordConfirmation = passwordConfirmationTextField.text ,passwordConfirmationTextField.text != "" ,password == passwordConfirmation else{
            confirmPasswordView.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
            confirmPasswordView.layer.borderWidth = 4
            print("empty passwordConfirmationTextField")
            return
        }
        
        
        //TODO:- generate device token and pass it
        guard let devToken = UIDevice.current.identifierForVendor?.uuidString else{return}
           
        
        
        
        
        
        
        let api : LogAPIProtocol = LogAPI()
        print("hello in my api")
        api.register(name: name,
                     email: email,
                     password: password,
                     passwordConfirm: passwordConfirmation,
                     mobileToken: devToken) { (result) in
                        //   print(result)
                        switch result {
                        case .success(let response):
                            //print("response in vc --> \(response)")
                           
                            guard let accessToken = response?.token else{return}
                            print(accessToken)
                            let saveAccessTokenSuccessful: Bool = KeychainWrapper.standard.set(accessToken, forKey: "accessToken")
                            print("is access token saved \(saveAccessTokenSuccessful)")
                           
                            guard let email = response?.user?.email else{return}
                            print(email)
                            let saveEmailSuccessful: Bool = KeychainWrapper.standard.set(email, forKey: "email")
                            print("is email saved \(saveEmailSuccessful)")
                            //TODO:- dismiss viewcontroller
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                            print("something went wrong")
                            //TODO:- show users errors in there paramters
                            
                            
                        }
        }
    }
    
    
    
    
}
