//
//  TechniqueType.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/24/23.
//

import SwiftUI


enum TechniqueType : String, Identifiable, Codable {
    
    case takedown
    case sweep
    case guardPass = "Guard Pass"
    case guardRetention = "Guard Retention" // stupid fix, will deal with it later
    case submission
    case escape
    
    var name: String {
        rawValue.capitalized
    }

    var id: String {
        name
    }
    
    // todo: create a function that computes theme based on type
    var theme: Theme {
        switch self {
        case .takedown: return .lavender
        case .sweep: return .sky
        case .guardPass: return .indigo
        case .guardRetention: return .teal
        case .submission: return .purple
        case .escape: return .navy
        }
    }
    
}


