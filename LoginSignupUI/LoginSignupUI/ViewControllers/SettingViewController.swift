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
        
        }
        
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        let homeVC = storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}


