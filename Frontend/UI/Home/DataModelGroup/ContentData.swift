//
//  ContentData.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import Foundation

struct ContentData: Identifiable,Codable {
    let category: policyCategory
    let id : Int
    let title: String
    let content: String
    let image: String
    let URL1: String
    let URL2: String
}

enum policyCategory: String, Codable, CaseIterable {
    case job = "JOB"
    case education = "EDUCATION"
    case dwelling = "DWELLING"
    case welfare = "WELFARE"
    
    
    func toKorean() -> String {
        switch self {
        case .job:
            return "취업"
        case .education:
            return "교육"
        case .dwelling:
            return "주거"
        case .welfare:
            return "복지"
        }
    }
}
