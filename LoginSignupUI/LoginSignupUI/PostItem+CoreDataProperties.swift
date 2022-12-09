//
//  PostItem+CoreDataProperties.swift
//  
//
//  Created by GTCSYS' Mac mini on 12/9/22.
//
//

import Foundation
import CoreData


extension PostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostItem> {
        return NSFetchRequest<PostItem>(entityName: "PostItem")
    }

    @NSManaged public var place: String?
    @NSManaged public var postImg: Data?
    @NSManaged public var desc: String?

}
