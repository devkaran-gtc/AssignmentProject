//
//  SettingViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var badge1: UILabel!
    @IBOutlet var badge2: UILabel!
    @IBOutlet var badge3: UILabel!
    @IBOutlet var badge4: UILabel!
    @IBOutlet var backBtn1: UIButton!
    @IBOutlet var backBtn2: UIButton!
    @IBOutlet var backBtn3: UIButton!
    @IBOutlet var backBtn4: UIButton!
    
  //  var diameter: CGFloat = 30.0
    override func viewDidLoad() {
        super.viewDidLoad()
        badge1?.layer.masksToBounds = true
        badge2?.layer.masksToBounds = true
        badge3?.layer.masksToBounds = true
        badge4?.layer.masksToBounds = true
        
        badge1.layer.cornerRadius = badge1.frame.size.width / 2
        badge2.layer.cornerRadius = badge2.frame.size.width / 2
        badge3.layer.cornerRadius = badge3.frame.size.width / 2
        badge4.layer.cornerRadius = badge4.frame.size.width / 2
        
        
        }
        
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        let homeVC = storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}


