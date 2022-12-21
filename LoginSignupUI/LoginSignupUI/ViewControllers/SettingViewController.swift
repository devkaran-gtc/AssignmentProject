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
    
    var profile: Profile?
  //  var diameter: CGFloat = 30.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        badge1?.layer.masksToBounds = true
        badge2?.layer.masksToBounds = true
        badge3?.layer.masksToBounds = true
        badge4?.layer.masksToBounds = true
        profileImage1.layer.masksToBounds = true

        badge1.layer.cornerRadius = badge1.frame.size.width / 2
        badge2.layer.cornerRadius = badge2.frame.size.width / 2
        badge3.layer.cornerRadius = badge3.frame.size.width / 2
        badge4.layer.cornerRadius = badge4.frame.size.width / 2
        profileImage1.layer.cornerRadius = profileImage1.frame.size.width / 2
    
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
        
        self.view1.addGestureRecognizer(gesture)
    }
        
    let gesture = UITapGestureRecognizer(target: self, action: #selector(navigate))
    

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


