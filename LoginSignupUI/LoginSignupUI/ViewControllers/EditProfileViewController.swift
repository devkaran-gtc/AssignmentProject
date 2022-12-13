//
//  EditProfileViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/6/22.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    var picker1:UIImagePickerController? = UIImagePickerController()
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var aboutTxtView: UITextView!
    
  //  var ref:DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        picker1?.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
 //       ref = Database.database().reference()
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        openGallary()
    }
    
    func openGallary()
    {
        picker1!.allowsEditing = false
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
//                if let vc3 = storyboard?.instantiateViewController(withIdentifier: "profile") as? ProfileViewController {
//                    vc3.profilenameLbl = nameTextField.text!
//                    vc3.profileImg = profileImage.image!
//                    vc3.about = aboutTxtView.text
//                    navigationController?.pushViewController(vc3, animated: true)
//                }
        
        let placeLbl = nameTextField.text ?? ""
        let desc = aboutTxtView.text ?? ""
        
        if let imageData = profileImage.image?.jpegData(compressionQuality: 1) {
            
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "ProfileViewController")
        mainTabBarController.modalPresentationStyle = .fullScreen
        
        self.present(mainTabBarController, animated: true, completion: nil)
    }
   
}

