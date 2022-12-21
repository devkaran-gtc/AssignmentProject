//
//  ForgotPasswordVC.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 11/30/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet var emailtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    @objc func backButtonClick(sender : UIButton) {
            self.navigationController?.popViewController(animated: true);
        }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

