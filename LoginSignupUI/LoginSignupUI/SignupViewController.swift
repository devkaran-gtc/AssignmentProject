//
//  SignupViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/8/22.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var checkBtn: UIButton!
    
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        errorLabel.alpha = 0
        
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        countryTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassTextField.delegate = self
        
        checkBtn.setImage(UIImage(systemName: "square"), for: .normal)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if userNameTextField.placeholder == "" {
            userNameTextField.textColor = .black
            userNameTextField.layer.cornerRadius = 7
            userNameTextField.layer.borderWidth = 1
            userNameTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if emailTextField.placeholder == "" {
            emailTextField.textColor = .black
            emailTextField.layer.cornerRadius = 7
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if countryTextField.placeholder == "" {
            countryTextField.textColor = .black
            countryTextField.layer.cornerRadius = 7
            countryTextField.layer.borderWidth = 1
            countryTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if passwordTextField.placeholder == "" {
            passwordTextField.textColor = .black
            passwordTextField.layer.cornerRadius = 7
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if confirmPassTextField.placeholder == "" {
            confirmPassTextField.textColor = .black
            confirmPassTextField.layer.cornerRadius = 7
            confirmPassTextField.layer.borderWidth = 1
            confirmPassTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if userNameTextField.text == "" {
            userNameTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if emailTextField.text == "" {
            emailTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if countryTextField.text == "" {
            countryTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if passwordTextField.text == "" {
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if confirmPassTextField.text == "" {
            confirmPassTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
    }
    @objc func backButtonClick(sender : UIButton) {
            self.navigationController?.popViewController(animated: true);
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // check the field and validate that the data is correct. If everthing is correct, this method return nil. otherwise it returns error message.
    func validateField() -> String? {
        
        // Check that all fields are filled in.
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || countryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPassTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        if flag == false {
            return "Please accept terms & conditions"
        }
        // Check if password is secure.
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // password isn't secure enough
            return "Please make sure your password is atleast 8 character, contain a special character and a number."
        }
        return nil
    }
    
    @IBAction func checkBtnTapped(_ sender: UIButton) {
        if flag {
            checkBtn.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            checkBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        flag = !flag
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        
        // validate fields
        let error = validateField()
        
        if error != nil {
            // There's something wrong with the fields, show error message.
            showError(error!)
        } else {
            
            // create cleaned version of the data.
            _ = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            _ = countryTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            _ = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            _ = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            _ = confirmPassTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // create the user
//            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//
//                // Check the error
//                if err != nil{
//
//                    // There was an error creating the user.
//                    self.showError("Error creating user.")
//                } else {
//                    // User was created successfully, now store the first name and last name
//                    let db = Firestore.firestore()
//                    db.collection("user").addDocument(data: ["firstname": username, "country": country, "uid": result!.user.uid]) { (error) in
//
//                        if error != nil {
//                            // Show error message
//                            self.showError("Error saving data user")
//                        }
//                    }
//                    // Transition to the home screen
//                    self.transitionToHome()
//                }
//            }
            
            
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeVC) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
}
