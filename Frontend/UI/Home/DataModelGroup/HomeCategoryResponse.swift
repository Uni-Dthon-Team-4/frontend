//
//  HomeCategoryResponse.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//

struct HomeCategoryRequest: Codable {
    let uuid: String
    let category: String
}

struct HomeCategoryResponse: Codable {
    let code: String
    let message: String
    let data: [HomeCategoryResponseData]
}

struct HomeCategoryResponseData: Identifiable, Codable {
    let policyId: Int
    let isScrapped: Bool?
    let name: String
    let description: String
    let category: String
    let age: String
    let url: String
    let applyUrl: String
    
    var id: Int { policyId }
}