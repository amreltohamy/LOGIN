//
//  ViewController.swift
//  Login
//
//  Created by MacBook on 8/3/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

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
        
      
        
      
      //  LogAPI.init()
        
        
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        
        guard let name = userNameTextField.text else{
            print("empty name")
            return
        }
        
        guard let email = UserEmailTextField.text else{
            print("empty name")
            return
        }
        
        guard let password = PasswordTextField.text else{
                   print("empty name")
                   return
               }
               
        guard let passwordConfirmation = passwordConfirmationTextField.text else{
                   print("empty name")
                   return
               }
               
        
        
        
        let mobileToken = "57246542-96fe-1a63-e053-0824d011072a"
        
        
        
        let api : LogAPIProtocol = LogAPI()
              api.register(name: name,
                           email: email,
                           password: password,
                           passwordConfirm: passwordConfirmation,
                           mobileToken: mobileToken) { (result) in
               //   print(result)
                  switch result {
                    case .success(let response):
            //print("response in vc --> \(response)")
                      print("token => \(response?.token)")
                      print("email => \(response?.user?.email)")

                    case .failure(let error):
                      print(error.localizedDescription)
                    print("something went wrong")
                  }
              }
    }
    
    
   

}

