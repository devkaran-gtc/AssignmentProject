//
//  Post1.swift
//  LoginSignupUI
//
//  Created by GTCSYS-Mac-Mini5 on 11/01/23.
//

import FirebaseCore
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SwiftyJSON

class Post1 {
    var place: String!
    var desc: String!
    var imageDownloadURL: String?
    private var img: UIImage!
    
    init(place: String, desc: String, img: UIImage) {
        self.place = place
        self.desc = desc
        self.img = img
    }
    
    init(snapshot: DataSnapshot) {
        let json = JSON(snapshot.value)
        self.imageDownloadURL = json["imageDownloadURL"].stringValue
        self.place = json["place"].stringValue
        self.desc = json["desc"].stringValue
    }
    
    func save() {
        let newPostRef = Database.database().reference().child("photoPost").childByAutoId()
        let newPostKey = newPostRef.key
        
        if let imageData = UIImage.jpegData(self.img)(compressionQuality: 0.6) {
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey!)
            newImageRef.putData(imageData, metadata: nil) { _, error in
                guard error == nil else {
                    print("Failed to upload")
                    return
                }
                newImageRef.downloadURL { imageDownloadURL, error in
                    guard let imageDownloadURL = imageDownloadURL, error == nil else {
                        return
                    }
                    let urlString = imageDownloadURL.absoluteString
                    let newPostDictionary = [
                        "place": self.place,
                        "desc": self.desc,
                        "imageDownloadURL": urlString
                        
                    ]
                    newPostRef.setValue(newPostDictionary)
                }
            }
        }
    }
}
