//
//  TermsViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS-Mac-Mini5 on 20/01/23.
//

import UIKit

class TermsViewController: UIViewController {

    @IBOutlet var txtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtView.text = load(file: "terms")
        
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
        
        
        func load(file name:String) -> String {
            
            if let path = Bundle.main.path(forResource: name, ofType: "txt") {
                
                if let contents = try? String(contentsOfFile: path) {
                    
                    return contents
                    
                } else {
                    
                    print("Error! - This file doesn't contain any text.")
                }
                
            } else {
                
                print("Error! - This file doesn't exist.")
            }
            
            return ""
        }
}
