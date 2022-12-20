//
//  FollowStatus.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/6/22.
//

import Foundation

protocol Togglable {
    mutating func toggle()
}

enum FollowStatus: Togglable {
    case follow, unfollow
    
    mutating func toggle() {
        switch self {
            case .follow:
                self = .unfollow
            
            case .unfollow:
                self = .follow
        }
    }
}
