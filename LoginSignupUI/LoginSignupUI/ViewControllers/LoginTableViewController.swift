//
//  LoginTableViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/29/22.
//

import UIKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        errorLabel.alpha = 0
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        // create cleaned version of the text field
//        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        // signing in the user
//        Auth.auth().signIn(withEmail: email, password: password) { (resule, error) in
//            
//            if error != nil {
//                
//                //couldn't sign in
//                self.errorLabel.text = error!.localizedDescription
//                self.errorLabel.alpha = 1
//            } else {
//                
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
//                mainTabBarController.modalPresentationStyle = .fullScreen
//                
//                self.present(mainTabBarController, animated: true, completion: nil)
//                
//            }
//        }
    }
    
}

