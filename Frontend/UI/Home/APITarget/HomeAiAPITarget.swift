//
//  HomeAiAPITarget.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//

import Foundation
import Alamofire

enum HomeAiAPITarget {
    case getPolicyDescription(policyName: String)
}

extension HomeAiAPITarget: BaseAPI {
    typealias Response = String
    
    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .getPolicyDescription:
            return "/bot/policy-description"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .getPolicyDescription(let policyName):
            return .query(["policyName": policyName])
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            "ngrok-skip-browser-warning": "true",
            "Accept": "application/json"
        ]
    }
}
