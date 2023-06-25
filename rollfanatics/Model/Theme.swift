//
//  Theme.swift
//  rollfanatics
//
//  Created by Борис Рябов on 6/25/23.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Codable {
    case indigo
    case lavender
    case navy
    case purple
    case sky
    case teal
    
    var accentColor: Color {
        switch self {
        case .lavender, .sky, .teal: return .black
        case .indigo, .navy, .purple: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
