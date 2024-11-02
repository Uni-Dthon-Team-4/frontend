//
//  HomeMyPolicyAPITarget.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//
import Foundation
import Alamofire

enum HomeMyPolicyAPITarget {
    case searchPolicies(HomeMyPolicyRequest)
}

extension HomeMyPolicyAPITarget: BaseAPI {
    typealias Response = HomeMyPolicyResponse
    
    var method: HTTPMethod {
        switch self {
        case .searchPolicies:
            return .get
        }
    }

    var path: String {
        switch self {
        case .searchPolicies:
            return "/api/policies/search"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .searchPolicies(let request):
            return .query(["keyword": request.keyword])
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "ngrok-skip-browser-warning": "true",
            "Content-Type": ContentType.json.rawValue
        ]
    }
}
