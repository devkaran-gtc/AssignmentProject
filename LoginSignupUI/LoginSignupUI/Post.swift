//
//  Post.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/7/22.
//


import UIKit
import Firebase

class Post {
    
    var name: String!
    var postImgURL: String?
    var postDescription: String!
    private var img: UIImage!
    
    init(name: String, img: UIImage, postDescription : String) {
        self.name = name
        self.img = img
        self.postDescription = postDescription
    }
    
    func saveData() {
        let newPostRef = Database.database().reference().child("photoPosts").childByAutoId()
    }
}
