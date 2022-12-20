//
//  FavoriteStatus.swift
//  LoginSignupUI
//
//  Created by GTCSYS' Mac mini on 12/19/22.
//

import Foundation

protocol Toggle {
    mutating func toggle()
}

enum FavoriteStatus: Toggle {
    case like, disLike
    
    mutating func toggle() {
        switch self {
            case .like:
                self = .disLike
            
            case .disLike:
                self = .like
        }
    }
}
