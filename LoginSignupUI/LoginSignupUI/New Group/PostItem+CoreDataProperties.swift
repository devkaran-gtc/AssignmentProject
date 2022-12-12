//
//  PostItem+CoreDataProperties.swift
//  
//
//  Created by GTCSYS' Mac mini on 12/12/22.
//
//

import Foundation
import CoreData


extension PostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCoreData> {
        return NSFetchRequest<PostCoreData>(entityName: "PostCoreData")
    }

    @NSManaged public var desc: String?
    @NSManaged public var place: String?
    @NSManaged public var postImg: Data?

}
