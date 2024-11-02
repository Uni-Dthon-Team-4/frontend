//
//  SignupRequestDTO.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

struct SignupRequestDTO: Codable {
    let userId: String
    let password: String
    let email: String
    let age: Int
    let keyword1: String?
    let keyword2: String?
    let keyword3: String?
    let address: String?
}
