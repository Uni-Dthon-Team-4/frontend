//
//  NetworkExAPI.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import Foundation
import Alamofire

/// 실제 서버 요청에 필요한 값들을 세팅합니다.

enum HomeAPI {
    case getHomePost(HomeRequest)
}

extension HomeAPI: BaseAPI {
    typealias Response = HomeResponse
    
    var method: HTTPMethod {
        switch self {
        case .getHomePost: return .get
        }
    }

    var path: String {
        switch self {
        case .getHomePost: return "/v2/posts"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .getHomePost(let request): return .query(request)
        }
    }
}
