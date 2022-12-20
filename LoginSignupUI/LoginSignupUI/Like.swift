//
//  Like.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/19/22.
//

import Foundation

struct Like: Decodable {
    let full_name: String
    let email: String
    let profile_image_url: String
    let is_like: Bool
}
