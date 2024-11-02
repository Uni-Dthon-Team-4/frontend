//
//  CheckDuplicateAPI.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation
import Alamofire

enum CheckDuplicateAPI {
    case getDuplicateCheck(CheckDuplicateRequestDTO)
}

extension CheckDuplicateAPI: BaseAPI {
    typealias Response = Bool
    
    var method: HTTPMethod {
        switch self {
        case .getDuplicateCheck: return .get
        }
    }

    var path: String {
        switch self {
        case .getDuplicateCheck: return "/api/member/check-duplicate"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .getDuplicateCheck(let request): return .query(request)
        }
    }
}
