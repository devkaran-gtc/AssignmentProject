//
//  EditProfile+CoreDataProperties.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/13/22.
//
//

import Foundation
import CoreData

extension EditProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EditProfile> {
        return NSFetchRequest<EditProfile>(entityName: "EditProfile")
    }

    @NSManaged public var about: String?
    @NSManaged public var name: String?
    @NSManaged public var profileImg: Data?

}

extension EditProfile : Identifiable {

}
