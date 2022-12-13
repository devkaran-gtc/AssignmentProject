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
    
    static let shareInstance = DatabaseHelper()
    
    func save(about:String, name:String, profileImg: Data) {
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let imageInstance = PostItem(context: managedContext)
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
    
    func fetchImage() -> [PostItem] {
        
        var fetchingImage = [PostItem]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return fetchingImage }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostItem")
        
        do {
            print("All data.")
            fetchingImage = try managedContext.fetch(fetchRequest) as! [PostItem]
        } catch {
            print(error)
        }
        
        return fetchingImage
    }
}
