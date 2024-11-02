//
//  HomeCategoryAPITarget.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//

import Foundation
import Alamofire

enum HomeCategoryAPITarget {
    case getPoliciesByAge(HomeCategoryRequest)
}

extension HomeCategoryAPITarget: BaseAPI {
    typealias Response = HomeCategoryResponse
    
    var method: HTTPMethod {
        switch self {
        case .getPoliciesByAge:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getPoliciesByAge:
            return "/api/policies/by-age"
        }
    }

    var parameters: RequestParams? {
        switch self {
        case .getPoliciesByAge(let request):
            return .query(["category": request.category])
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getPoliciesByAge(let request):
            return [
                "ngrok-skip-browser-warning": "true",
                "uuid": request.uuid,
                "Content-Type": ContentType.json.rawValue
            ]
        }
    }
}
