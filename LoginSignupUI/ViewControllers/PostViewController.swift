//
//  PostViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import UIKit

class PostViewController: UIViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet var placeTextField: UITextField!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var descriptionTxtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        configureItems()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func configureItems() {
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ArrowIcon"), for: .normal)
        button.backgroundColor = UIColor(red: 77/255, green: 217/255, blue: 105/255, alpha: 1)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        button.layer.cornerRadius = 3
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
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
    
    @IBAction func saveBtnTapped(_ sender: Any) {
    }
    
}
