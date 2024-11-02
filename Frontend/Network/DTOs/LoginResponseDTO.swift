//
//  LoginResponseDTO.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation

struct LoginResponseDTO: Codable {
    let userId: String
    let email: String
    let uuid: String
}
