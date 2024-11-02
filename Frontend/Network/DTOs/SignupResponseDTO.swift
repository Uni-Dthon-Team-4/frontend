//
//  SignupResponseDTO.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

struct SignupResponseDTO: Codable {
    let id: Int
    let userId: String
    let email: String
    let uuid: String
    let age: Int
    let keyword1: String?
    let keyword2: String?
    let keyword3: String?
    let address: String?
}
