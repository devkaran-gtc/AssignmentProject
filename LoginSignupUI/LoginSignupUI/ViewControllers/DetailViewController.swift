//
//  DetailViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var postImage: UIImageView!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var descriptionTxtView: UITextView!
    
    var post = UIImage()
    var profile = UIImage()
    var nameLbl = ""
    var placeLbl = ""
    var descriptionlbl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        postImage.image = post
        profileImg.image = profile
        name.text = nameLbl
        place.text = placeLbl
        descriptionTxtView.text = descriptionlbl
    
        let backImage = UIImage(named: "ic_back")
        let menuBtn = UIButton(type: .custom)
        menuBtn.setImage(backImage, for: .normal)
        menuBtn.addTarget(self, action: #selector(backButtonClick(sender:)), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 46).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
        
        descriptionTxtView.delegate = self
        descriptionTxtView.text = "Description"
        descriptionTxtView.textColor = UIColor.lightGray
        descriptionTxtView.layer.cornerRadius = 7
        descriptionTxtView.layer.borderWidth = 0.3
        descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        
        self.hidekeyboard()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTxtView.textColor == UIColor.lightGray {
            descriptionTxtView.text = ""
            descriptionTxtView.textColor = .black
            descriptionTxtView.layer.borderWidth = 1
            descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.3019607843, green: 0.8509803922, blue: 0.4117647059, alpha: 1)
            
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionTxtView.text == "" {
            descriptionTxtView.text = "Description"
            descriptionTxtView.textColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
            descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1)
        }
        
    }
    
    @objc func backButtonClick(sender : UIButton) {
            self.navigationController?.popViewController(animated: true);
        }
}
