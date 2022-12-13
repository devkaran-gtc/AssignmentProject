//
//  DatabaseHelper.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    
    static let shareInstance = DatabaseHelper()
    
    func save(desc:String, place:String, postImg: Data) {
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let imageInstance = PostItem(context: managedContext)
        imageInstance.desc = desc
        imageInstance.place = place
        imageInstance.postImg = postImg
       
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
    
    func deleteData(place: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostItem")
        fetchRequest.predicate = NSPredicate(format: "place = %@", place)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                print("deleted.")
                try managedContext.save()
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
    func updateItem(desc1: String, place1: String, postImg1: Data) {
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let imageInstance = PostItem(context: managedContext)
        imageInstance.desc = desc1
        imageInstance.place = place1
        imageInstance.postImg = postImg1
       
        do {
            print("update.")
            try managedContext.save()
        } catch let error as NSError {
            print("could not update. \(error), \(error.userInfo)")
        }
    }
}
    

