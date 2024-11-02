//
//  SignupAPI.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation
import Alamofire

enum SignupAPI {
    case postSignup(SignupRequestDTO)
}

extension SignupAPI: BaseAPI {
    typealias Response = SignupResponseDTO
    
    var method: HTTPMethod {
        switch self {
        case .postSignup: return .post
        }
    }

    var path: String {
        switch self {
        case .postSignup: return "/api/member/join"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .postSignup(let request): return .body(request)
        }
    }
}
