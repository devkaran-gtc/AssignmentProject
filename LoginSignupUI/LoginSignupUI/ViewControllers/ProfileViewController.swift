//
//  ProfileViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/6/22.
//

import UIKit
import CoreData
class ProfileViewController: UIViewController {
    
    var post = [EditProfile]()
    @IBOutlet var profileImgView: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var aboutLbl: UILabel!
    
    var profileImg = UIImage()
    var profilenameLbl = ""
    var about = ""
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profileImgView.image = profileImg
        profileName.text = profilenameLbl
        aboutLbl.text = about
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        downloadJSON {
            self.profileName?.text = self.profile?.full_name
            self.aboutLbl?.text = self.profile?.about_me
            let imageurl = self.profile?.imageurl
            let url = URL(string: imageurl!)
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.profileImgView.image = image
            }else {
                self.profileImgView.image = nil
            }
            print("Success")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    
    }
    
    func loadData() {
        post = Post.shareInstance.fetchData()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        vc?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC1 = storyboard.instantiateViewController(identifier: "SettingViewController")
        VC1.modalPresentationStyle = .fullScreen
        
        self.present(VC1, animated: true, completion: nil)
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "http://192.168.1.34:3000/profile")
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
