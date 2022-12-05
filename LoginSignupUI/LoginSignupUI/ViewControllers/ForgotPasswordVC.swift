//
//  ForgotPasswordVC.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit
import SkyFloatingLabelTextField
import TPKeyboardAvoidingSwift

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet var emailtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

