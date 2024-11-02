//
//  SearchCache.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation

struct SearchCache: Codable {
    var searches: Set<String>
    var keywords: Set<String>
    var policies: Set<RelevantPolicy>
}
