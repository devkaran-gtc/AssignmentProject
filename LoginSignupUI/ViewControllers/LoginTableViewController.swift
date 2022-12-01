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
    let email = "Admin"
    let password = "Admin"
    override func viewDidLoad() {
        super.viewDidLoad()

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
       
        
    }
}
    

