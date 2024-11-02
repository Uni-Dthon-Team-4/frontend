//
//  AgeEnum.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//

import Foundation

enum ageEnum: String {
    case youth = "YOUTH"
    case middleAged = "MIDDLE_AGED"
    case old = "SENIOR"

    var imageName: String {
        switch self {
        case .youth:
            return "YOUTH"
        case .middleAged:
            return "MIDDLE_AGED"
        case .old:
            return "SENIOR"
        }
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "YOUTH":
            self = .youth
        case "MIDDLE_AGED":
            self = .middleAged
        case "OLD":
            self = .old
        default:
            return nil
        }
    }
}
