//
//  HomeMyPolicyData.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//

import Foundation

struct HomeMyPolicyRequest: Codable {
    let keyword: String
}


struct HomeMyPolicyResponse: Codable {
    let code: String
    let message: String
    let data: [HomeMyPolicyResponseData]
}

struct HomeMyPolicyResponseData: Identifiable, Codable, Equatable {
    let policyId: Int
    let name: String
    let description: String
    let category: String
    let age: String
    let url: String
    
    var id: Int { policyId }
    
    private enum CodingKeys: String, CodingKey {
            case policyId = "policyId"
            case name = "name"
            case description = "description"
            case category = "category"
            case age = "age"
            case url = "url"
        }
}
