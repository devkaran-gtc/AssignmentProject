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
    @IBOutlet var profileImage1: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var logOutBtn: UIButton!
    
    var profile: Profile?
  //  var diameter: CGFloat = 30.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view2.layer.masksToBounds = true
        view3.layer.masksToBounds = true
        view4.layer.masksToBounds = true

        view2.layer.cornerRadius = 7
        view2.layer.borderWidth = 1
        view2.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view3.layer.cornerRadius = 7
        view3.layer.borderWidth = 1
        view3.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        view4.layer.cornerRadius = 7
        view4.layer.borderWidth = 1
        view4.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        badge1?.layer.masksToBounds = true
        badge2?.layer.masksToBounds = true
        badge3?.layer.masksToBounds = true
        badge4?.layer.masksToBounds = true
        profileImage1.layer.masksToBounds = true
        logOutBtn.layer.masksToBounds = true
        
        badge1.layer.cornerRadius = badge1.frame.size.width / 2
        badge2.layer.cornerRadius = badge2.frame.size.width / 2
        badge3.layer.cornerRadius = badge3.frame.size.width / 2
        badge4.layer.cornerRadius = badge4.frame.size.width / 2
        profileImage1.layer.cornerRadius = profileImage1.frame.size.width / 2
        profileImage1.layer.borderWidth = 3
        profileImage1.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4196078431, alpha: 1)
        logOutBtn.layer.borderWidth = 0.2
        logOutBtn.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4196078431, alpha: 1)
    
        downloadJSON {
            self.profileName?.text = self.profile?.full_name
            self.email?.text = self.profile?.email
            let imageurl = self.profile?.imageurl
            let url = URL(string: imageurl!)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.profileImage1.image = image
            }else {
                self.profileImage1.image = nil
            }
            print("Success")
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigate))
        self.view1.addGestureRecognizer(gesture)
    }

    @objc func navigate(_ sender:UITapGestureRecognizer){
        let vc = storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        let homeVC = storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://192.168.1.71:3000/profile")
        URLSession.shared.dataTask(with: url!) { (data, response, err) in

            if err == nil {
                do {
                    self.profile = try JSONDecoder().decode(Profile.self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error fatching \(error)")
                }


            }
        }.resume()
    }
}


