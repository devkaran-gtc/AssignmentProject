//
//  Followers.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/19/22.
//

import Foundation

struct Followers: Decodable {
    let full_name: String
    let email: String
    let profile_image_url: String
}

struct Follower: Codable {
    let following: Bool
}
