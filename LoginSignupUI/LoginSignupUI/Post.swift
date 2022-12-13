//
//  Post.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/7/22.
//


import Foundation
import CoreData
import UIKit

class Post {
    
    static let shareInstance = Post()
    
    func saveData(about:String, name:String, profileImg: Data) {
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let imageInstance = EditProfile(context: managedContext)
        imageInstance.about = about
        imageInstance.name = name
        imageInstance.profileImg = profileImg
       
        do {
            print("saved.")
            try managedContext.save()
        } catch let error as NSError {
            print("could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchData() -> [EditProfile] {
        
        var fetchData = [EditProfile]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return fetchData }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EditProfile")
        
        do {
            print("All data.")
            fetchData = try managedContext.fetch(fetchRequest) as! [EditProfile]
        } catch {
            print(error)
        }
        
        return fetchData
    }
}
