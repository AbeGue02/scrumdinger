//
//  Theme.swift
//  Scrumdinger
//
//  Created by Abraham Guerrero on 10/20/24.
//

import SwiftUI

enum Theme: String {
    case orange
    case red
    case yellow
    
    var accentColor: Color {
        return .black
    }
    
    var mainColor: Color {
        switch self {
        case .orange:
            return .orange
        case .red:
            return .red
        case .yellow:
            return .yellow
        }
    }
}
