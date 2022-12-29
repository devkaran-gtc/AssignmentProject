//
//  SignupViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/8/22.
//

import UIKit

class SignupViewController: UIViewController {
    
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
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//            imageView.isUserInteractionEnabled = true
//            imageView.addGestureRecognizer(tapGestureRecognizer)
        
        checkBtn.setImage(UIImage(systemName: "square"), for: .normal)
      
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if flag {
            checkBtn.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            checkBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        flag = !flag
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
            return "Please accept Terms & Conditions"
        }
        
        // Check if password is secure.
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // password isn't secure enough
            return "Please make sure your password is atleast 8 character, contain a special character and a number."
        }
        return nil
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
