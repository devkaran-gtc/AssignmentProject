//
//  EditProfile+CoreDataProperties.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/12/22.
//
//

import Foundation
import CoreData


extension EditProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EditProfile> {
        return NSFetchRequest<EditProfile>(entityName: "EditProfile")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImg: Data?
    @NSManaged public var about: String?

}

extension EditProfile : Identifiable {

}
