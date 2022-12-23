//
//  Profile.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/16/22.
//

import Foundation

struct Profile: Codable {
    let full_name: String
    let email: String
    let imageurl: String
    let about_me: String
    let followers: Int
    let following: Int
}
