//
//  ProfileViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/6/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var aboutLbl: UILabel!
    
    var profileImg = UIImage()
    var profilenameLbl = ""
    var about = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profileImgView.image = profileImg
        profileName.text = profilenameLbl
        aboutLbl.text = about
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyboard.instantiateViewController(identifier: "SettingViewController")
        VC1.modalPresentationStyle = .fullScreen
        
        self.present(VC1, animated: true, completion: nil)
    }
}
