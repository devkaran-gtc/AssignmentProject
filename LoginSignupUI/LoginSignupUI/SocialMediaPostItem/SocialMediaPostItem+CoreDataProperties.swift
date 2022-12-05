//
//  SocialMediaPostItem+CoreDataProperties.swift
//  
//
//  Created by GTCSYS' Mac mini on 12/5/22.
//
//

import Foundation
import CoreData


extension SocialMediaPostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SocialMediaPostItem> {
        return NSFetchRequest<SocialMediaPostItem>(entityName: "SocialMediaPostItem")
    }

    @NSManaged public var decription: String?
    @NSManaged public var place: String?
    @NSManaged public var postImg: String?

}
