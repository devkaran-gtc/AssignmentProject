//
//  PostItem+CoreDataProperties.swift
//  LoginSignupUI
//
//  Created by Devkaran's Mac mini on 13/12/22.
//
//

import Foundation
import CoreData


extension PostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostItem> {
        return NSFetchRequest<PostItem>(entityName: "PostItem")
    }

    @NSManaged public var desc: String?
    @NSManaged public var place: String?
    @NSManaged public var postImg: Data?

}

extension PostItem : Identifiable {

}
