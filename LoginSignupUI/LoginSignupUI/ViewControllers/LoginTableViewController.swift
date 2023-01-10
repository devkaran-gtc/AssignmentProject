//
//  LoginTableViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/29/22.
//

import UIKit
import FirebaseAuth

class LoginTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.hidekeyboard()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if emailTextField.placeholder == "" {
            emailTextField.textColor = .black
            emailTextField.layer.cornerRadius = 7
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if passwordTextField.placeholder == "" {
            passwordTextField.textColor = .black
            passwordTextField.layer.cornerRadius = 7
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if emailTextField.text == "" {
            emailTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if passwordTextField.text == "" {
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
    }
    
    @objc func backButtonClick(sender : UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc!, animated: true)
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
    
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        let nav = storyboard?.instantiateViewController(withIdentifier: "SignUp") as? SignupViewController
        nav?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(nav!, animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
         //create cleaned version of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        // signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (resule, error) in

            if error != nil {

                //couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                mainTabBarController.modalPresentationStyle = .fullScreen

                self.present(mainTabBarController, animated: true, completion: nil)

            }
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
//        mainTabBarController.modalPresentationStyle = .fullScreen
//
//        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
}



