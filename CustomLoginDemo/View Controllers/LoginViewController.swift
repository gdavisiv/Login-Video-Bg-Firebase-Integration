//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Gdavisiv on 1/8/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        //Hide the error lable
        errorLabel.alpha = 0
        
        //Styles the elements in the Login View Controller
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        //Validate Text Fields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //https://firebase.google.com/docs/auth/ios/start?authuser=0
        //Signin the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                //Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                //If login works then send user to login screen
                self.transitionToHome()
            }
        }
    }
    
    func transitionToHome() {
        
        //This creates a reference to our homeViewController
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
