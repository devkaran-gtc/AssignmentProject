//
//  DetailViewController.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import UIKit

class DetailViewController: UIViewController {

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
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
