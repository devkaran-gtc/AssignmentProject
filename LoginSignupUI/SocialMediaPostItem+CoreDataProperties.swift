//
//  SocialMediaPostItem+CoreDataProperties.swift
//  
//
//  Created by GTCSYS' Mac mini on 12/1/22.
//
//

import Foundation
import CoreData


extension SocialMediaPostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SocialMediaPostItem> {
        return NSFetchRequest<SocialMediaPostItem>(entityName: "SocialMediaPostItem")
    }

    @NSManaged public var profileImg: Data?
    @NSManaged public var name: String?
    @NSManaged public var place: String?
    @NSManaged public var postImg: Data?
    @NSManaged public var decription: String?

}
