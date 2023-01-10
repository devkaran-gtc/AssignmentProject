//
//  EditProfileViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/6/22.
//

import UIKit
import CoreData

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var picker1:UIImagePickerController? = UIImagePickerController()
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailLbl: UITextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var aboutTxtView: UITextView!
    @IBOutlet var saveBtn: UIButton!
    @IBOutlet var addImageBtn: UIButton!
    
  //  var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        picker1?.delegate = self
        
 //       ref = Database.database().reference()
    
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        aboutTxtView.delegate = self
        aboutTxtView.text = "About me"
        aboutTxtView.textColor = UIColor.lightGray
        aboutTxtView.layer.cornerRadius = 7
        aboutTxtView.layer.borderWidth = 1
        aboutTxtView.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        addImageBtn.layer.masksToBounds = true
        addImageBtn.layer.cornerRadius = 15
        addImageBtn.layer.borderWidth = 1
        addImageBtn.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
        nameTextField.delegate = self
        emailLbl.delegate = self
        
        self.hidekeyboard()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameTextField.placeholder == "" {
            nameTextField.textColor = .black
            nameTextField.layer.cornerRadius = 7
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
        
        if emailLbl.placeholder == "" {
            emailLbl.textColor = .black
            emailLbl.layer.cornerRadius = 7
            emailLbl.layer.borderWidth = 1
            emailLbl.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nameTextField.text == "" {
            nameTextField.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
        
        if emailLbl.text == "" {
            emailLbl.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if aboutTxtView.textColor == UIColor.lightGray {
            aboutTxtView.text = ""
            aboutTxtView.textColor = .black
            aboutTxtView.layer.borderWidth = 1
            aboutTxtView.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutTxtView.text == "" {
            aboutTxtView.text = "About me"
            aboutTxtView.textColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
            aboutTxtView.layer.borderColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        }
        
    }
    
    @objc func backButtonClick(sender : UIButton) {
            self.navigationController?.popViewController(animated: true);
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        openGallary()
    }
    
    func openGallary()
    {
        picker1!.allowsEditing = true
        picker1!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker1!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if let vc3 = storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
            vc3.profilenameLbl = nameTextField.text!
            vc3.profileImg = profileImage.image!
            vc3.about = aboutTxtView.text
            if let imageData = profileImage.image?.jpegData(compressionQuality: 1) {
            Post.shareInstance.saveData(about: aboutTxtView.text!, name: nameTextField.text!, profileImg: imageData)
            }
            navigationController?.pushViewController(vc3, animated: true)
            setUpPutMethod()
        }
        
//        let nameLbl = nameTextField.text ?? ""
//        let about = aboutTxtView.text ?? ""
//
//        if let imagedata = profileImage.image?.jpegData(compressionQuality: 1) {
//            Post.shareInstance.saveData(about: about, name: nameLbl, profileImg: imagedata)
//        }
//        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "ProfileViewController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        
        self.present(mainTabBarController, animated: true, completion: nil)
    }
    
    func setUpPutMethod() {
        guard let name = self.nameTextField.text else { return }
        guard let email = self.emailLbl.text else { return }
        let profile = "https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"
        guard let about = self.aboutTxtView.text else { return }
        
        if let url = URL(string: "http://192.168.1.71:3000/profile"){
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") 
            request.httpMethod = "PUT"
            
            let parameters: [String: String] = [
                "full_name": name,
                "email": email,
                "imageurl": profile,
                "about_me": about
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if error == nil{
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse{
                    guard (200 ... 299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

