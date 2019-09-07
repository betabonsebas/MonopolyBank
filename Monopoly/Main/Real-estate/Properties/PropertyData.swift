//
//  Land.swift
//  MonopolyBank
//
//  Created by Sebastian Bonilla on 7/19/19.
//  Copyright © 2019 bonsebas. All rights reserved.
//

import Foundation

enum PropertyColor: String, Codable {
    case brown
    case lightBlue
    case pink
    case orange
    case red
    case yellow
    case green
    case blue
    case white
    case black
    
    var buildingPrice: Int {
        switch self {
        case .brown, .lightBlue:
            return 50
        case .pink, .orange:
            return 100
        case .red, .yellow:
            return 150
        case .green, .blue:
            return 200
        case .white, .black:
            return 0
        }
    }
    
    var buildingSellPrice: Int {
        switch self {
        case .brown, .lightBlue:
            return 25
        case .pink, .orange:
            return 50
        case .red, .yellow:
            return 75
        case .green, .blue:
            return 100
        case .white, .black:
            return 0
        }
    }
}

struct PropertyData: Codable {
    let color: PropertyColor
    let title: String
    let listPrice: Int
    let mortgage: Int
    
    var buildingPrice: Int {
        return color.buildingPrice
    }
    
    var buildingSellPrice: Int {
        return color.buildingSellPrice
    }
    
}
