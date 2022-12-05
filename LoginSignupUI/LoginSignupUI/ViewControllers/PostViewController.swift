//
//  PostViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import UIKit
import TPKeyboardAvoidingSwift

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var descriptionTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImage.contentMode = .scaleAspectFit
            postImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        if let vc2 = storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeTableViewCell {
            vc2.placeLbl.text = placeTextField.text
            vc2.postImg.image = postImage.image
            vc2.descriptionTextView.text = descriptionTxtView.text
        }
    }
}

