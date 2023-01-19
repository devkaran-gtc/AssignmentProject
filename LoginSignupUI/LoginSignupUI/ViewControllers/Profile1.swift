//
//  Profile1.swift
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

class Profile1 {
    var name: String!
    var email: String!
    var desc1: String!
    var imageDownloadURL1: String?
    private var img1: UIImage!
    
    init(name: String, email: String, img1: UIImage, desc1: String) {
        self.name = name
        self.email = email
        self.img1 = img1
        self.desc1 = desc1
    }
    
    init(snapshot: DataSnapshot) {
        let json = JSON(snapshot.value)
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.imageDownloadURL1 = json["imageDownloadURL1"].stringValue
        self.desc1 = json["desc1"].stringValue
    }
    
    func save() {
        let newPostRef = Database.database().reference().child("profile")
        let newPostKey = newPostRef.key
        
        if let imageData = UIImage.jpegData(self.img1)(compressionQuality: 0.6) {
            let imageStorageRef = Storage.storage().reference().child("image")
            let newImageRef = imageStorageRef.child(newPostKey!)
            newImageRef.putData(imageData, metadata: nil) { _, error in
                guard error == nil else {
                    print("Failed to upload")
                    return
                }
                newImageRef.downloadURL { imageDownloadURL1, error in
                    guard let imageDownloadURL1 = imageDownloadURL1, error == nil else {
                        return
                    }
                    let urlString = imageDownloadURL1.absoluteString
                    let newPostDictionary1 = [
                        "name": self.name,
                        "email": self.email,
                        "imageDownloadURL1": urlString,
                        "desc1": self.desc1
                    ]
                    newPostRef.setValue(newPostDictionary1) { (error, newImageRef) in
                        if let error = error {
                            print("Error updating user data: \(error)")
                        } else {
                            print("User data updated successfully")
                        }
                    }
                }
            }
        }
    }
}










//func save() {
//    let newPostRef = Database.database().reference().child("profile")
//    let newPostKey = newPostRef.key
//
//    if let imageData = UIImage.jpegData(self.img1)(compressionQuality: 0.6) {
//        let imageStorageRef = Storage.storage().reference().child("image")
//        let newImageRef = imageStorageRef.child(newPostKey!)
//        newImageRef.putData(imageData, metadata: nil) { _, error in
//            guard error == nil else {
//                print("Failed to upload")
//                return
//            }
//            newImageRef.downloadURL { imageDownloadURL1, error in
//                guard let imageDownloadURL1 = imageDownloadURL1, error == nil else {
//                    return
//                }
//                let urlString = imageDownloadURL1.absoluteString
//                var newPostDictionary1 = [String: Any]()
//                newPostDictionary1["name"] = self.name
//                newPostDictionary1["email"] =  self.email
//                newPostDictionary1["imageDownloadURL1"] = urlString
//                newPostDictionary1["desc1"] = self.desc1
//
//                newPostRef.setValue(newPostDictionary1) { (error, newImageRef) in
//                    if let error = error {
//                        print("Error updating user data: \(error)")
//                    } else {
//                        print("User data updated successfully")
//                    }
//                }
//            }
//        }
//    }
//}
