//
//  SearchResult.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation

struct SearchResult: Identifiable {
    var id: UUID = UUID()
    var isError: Bool
    var isLoading: Bool
    var search: String
    var message: String
}
