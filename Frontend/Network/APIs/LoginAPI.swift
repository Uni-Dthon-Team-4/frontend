//
//  LoginAPI.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation
import Alamofire

enum LoginAPI {
    case postLogin(LoginRequestDTO)
}

extension LoginAPI: BaseAPI {
    typealias Response = SignupResponseDTO
    
    var method: HTTPMethod {
        switch self {
        case .postLogin: return .post
        }
    }

    var path: String {
        switch self {
        case .postLogin: return "/api/member/login"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .postLogin(let request): return .body(request)
        }
    }
}
