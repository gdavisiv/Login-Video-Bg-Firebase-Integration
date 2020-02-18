//
//  SignUpViewController.swift
//  CustomLoginDemo
//
//  Created by Gdavisiv on 1/8/20.
//  Copyright © 2020 George Davis IV. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements() {
        
        //Hide the Error label
        errorLabel.alpha = 0
        
        //Style the different elements in View Controllers
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }

    //Check the fields and validate that the data is correct.  If everything
    //is correct, this method returns nil.  Otherwise it retuns the error message
    func validateFields() -> String?{
        
        //Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
            return "Please fill in all fields"
        }
        
        //Check if the password is secure!
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password is not secure enough
            return "Please make sure your password is at least 8 character, contains a special character and number"
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        //Validate the fields
        let error = validateFields()
        
        if error != nil{
            
        //There is something wrong with the fields! : Show error message!
        showError(error!)
        }
        else {
            
            //Create cleaned versions of data!
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //How to authenticate with Firebase : https://firebase.google.com/docs/auth/ios/password-auth?authuser=0
            //Using the documentation for iOS->SWIFT provides walkthroughs
            
            //Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //Check for Errors
                if err != nil {
                    //There was an error creating the user
                    self.showError("Error Creating User")
            }
            else {
                //User was successfully created, now store the first name/last/email/pass
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            self.showError("User data could not uploaded, please try again")
                        }
                    }
                    //Transition to Home Screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
        func transitionToHome() {
            
            //This creates a reference to our homeViewController
            let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
            
            view.window?.rootViewController = homeViewController
            view.window?.makeKeyAndVisible()
        }
}
