//
//  SettingViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//

import UIKit
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import UserNotifications

class SettingViewController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet var badge1: UILabel!
    @IBOutlet var badge2: UILabel!
    @IBOutlet var badge3: UILabel!
    @IBOutlet var badge4: UILabel!
    @IBOutlet var badge5: UILabel!
    @IBOutlet var backBtn1: UIButton!
    @IBOutlet var backBtn2: UIButton!
    @IBOutlet var backBtn3: UIButton!
    @IBOutlet var backBtn4: UIButton!
    @IBOutlet var backBtn5: UIButton!
    @IBOutlet var follower: UILabel!
    @IBOutlet var following: UILabel!
    @IBOutlet var profileImage1: UIImageView!
    @IBOutlet var profileName: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    @IBOutlet var view6: UIView!
    @IBOutlet var view7: UIView!
    @IBOutlet var view8: UIView!
    @IBOutlet var view9: UIView!
    @IBOutlet var timeTextField: UITextField!
    @IBOutlet var logOutBtn: UIButton!
    
    var profile: Profile?

    let timePicker = UIDatePicker()
    let notificationCenter = UNUserNotificationCenter.current()
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
        badge5?.layer.masksToBounds = true
        profileImage1.layer.masksToBounds = true
        logOutBtn.layer.masksToBounds = true
        
        badge1.layer.cornerRadius = badge1.frame.size.width / 2
        badge2.layer.cornerRadius = badge2.frame.size.width / 2
        badge3.layer.cornerRadius = badge3.frame.size.width / 2
        badge4.layer.cornerRadius = badge4.frame.size.width / 2
        badge5.layer.cornerRadius = badge5.frame.size.width / 2
        profileImage1.layer.cornerRadius = profileImage1.frame.size.width / 2
        profileImage1.layer.borderWidth = 3
        profileImage1.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4196078431, alpha: 1)
        logOutBtn.layer.borderWidth = 0.2
        logOutBtn.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4196078431, alpha: 1)
        logOutBtn.layer.cornerRadius = 7
    
//        downloadJSON {
//            self.profileName?.text = self.profile?.full_name
//            self.email?.text = self.profile?.email
//            self.follower.text = "\((self.profile?.followers)!)"
//            self.following.text = "\((self.profile?.following)!)"
//            let imageurl = self.profile?.imageurl
//            let url = URL(string: imageurl!)
//            let data = try? Data(contentsOf: url!)
//            if let imageData = data {
//                let image = UIImage(data: imageData)
//                self.profileImage1.image = image
//            }else {
//                self.profileImage1.image = nil
//            }
//            print("Success")
//        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigate))
        self.view1.addGestureRecognizer(gesture)
        
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(navigate1))
        self.view8.addGestureRecognizer(gesture1)
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.frame.size = CGSize(width: 0, height: 200)
        self.view.addSubview(timePicker)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view9.addGestureRecognizer(gesture2)
        
        UNUserNotificationCenter.current().delegate = self
                
        notificationCenter.requestAuthorization(options: [.alert]) { permissionGranted, error in
            if(!permissionGranted){
                print("Permission Denied")
            }
        }
        
        retriveData()
    }
    
    func retriveData() {
        Database.database().reference().child("profile").observeSingleEvent(of: .value) { (snapshot) in
            if let snapshotValue = snapshot.value as? [String: Any] {
                self.profileName.text = snapshotValue["name"] as? String
                self.email.text = snapshotValue["email"] as? String
                let imgUrl = snapshotValue["imageDownloadURL1"] as? String
                let url = URL(string: imgUrl!)
                let data = try? Data(contentsOf: url!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.profileImage1.image = image
                }else {
                    self.profileImage1.image = nil
                }
            }
        }
    }
    
    @objc func viewTapped(_ sender:UITapGestureRecognizer){
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timeTextField.inputView = timePicker
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
         if touch?.view == self.view {
            timePicker.removeFromSuperview()
        }
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        timeTextField.text  = formatter.string(from: sender.date)
        
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                if(settings.authorizationStatus == .authorized) {
                    let content = UNMutableNotificationContent()
                    content.title = "Friends Network"
                    content.body = "It's time to check new posts for the Day!"

                    let dateComp = Calendar.current.dateComponents([.hour, .minute], from: self.timePicker.date)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    self.notificationCenter.add(request) { error in
                        if(error != nil) {
                            print("Error" + error.debugDescription)
                            return
                        }
                    }

                } else {
                    let ac = UIAlertController(title: "Enable Notification?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                    let goToSetting = UIAlertAction(title: "Settings", style: .default) { _ in
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
                        else {
                            return
                        }

                        if(UIApplication.shared.canOpenURL(settingsURL)) {
                            UIApplication.shared.open(settingsURL) { _ in }
                        }
                    }
                    ac.addAction(goToSetting)
                    ac.addAction(UIAlertAction(title: "Cancle", style: .default, handler: { _ in }))
                    self.present(ac, animated: true)
                }
            }
        }
    }

    @objc func navigate1(_ sender:UITapGestureRecognizer){
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "terms") as? termViewController
        vc1?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc1!, animated: true)
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
    
//    func downloadJSON(completed: @escaping () -> ()) {
//        let url = URL(string: "http://192.168.1.33:3000/profile")
//        URLSession.shared.dataTask(with: url!) { (data, response, err) in
//
//            if err == nil {
//                do {
//                    self.profile = try JSONDecoder().decode(Profile.self, from: data!)
//                    DispatchQueue.main.async {
//                        completed()
//                    }
//                } catch {
//                    print("error fatching \(error)")
//                }
//
//
//            }
//        }.resume()
//    }
}

