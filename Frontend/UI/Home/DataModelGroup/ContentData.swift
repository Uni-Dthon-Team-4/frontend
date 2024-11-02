//
//  ContentData.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import Foundation

struct ContentData: Codable {
    let category: String
    let id : Int
    let title: String
    let content: String
    let image: String
    let URL1: String
    let URL2: String
    let location: String
}

enum TipsCategory: String, Codable, CaseIterable {
    case all = "ALL"
    
    func toKorean() -> String {
        switch self {
        case .all:
            return "전체"
        }
    }
}
