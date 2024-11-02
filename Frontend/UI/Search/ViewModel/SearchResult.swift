//
//  SearchResult.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation

struct SearchResult: Identifiable {
    var id: UUID = UUID()
    var isLoading: Bool
    var search: String
    var message: String
    var keywords: [String]
    var policies: [RelevantPolicy]
}

struct RelevantPolicy: Codable, Identifiable, Hashable {
    var id: Int { policyID }
    var policyID: Int
    var name: String
    var description: String
    var url: String
    var age: String
}
