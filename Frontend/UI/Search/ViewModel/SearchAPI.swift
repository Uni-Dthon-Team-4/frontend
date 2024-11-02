//
//  SearchBaseAPI.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import Foundation
import Alamofire

enum SearchAPI {
    case getMessage(SearchRequest)
}

extension SearchAPI: BaseAPI {
    typealias Response = String
    
    var method: HTTPMethod {
        switch self {
        case .getMessage(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getMessage(_):
            return "/bot/chat"
        }
    }
    
    var parameters: RequestParams? {
        switch self {
        case .getMessage(let request): return .query(request)
        }
    }
}

struct SearchRequest: Encodable {
    var prompt: String
}

struct SearchService {
    static func get(request: SearchRequest) async throws -> String {
        try await withCheckedThrowingContinuation { configuration in
            AF.request(SearchAPI.getMessage(request).urlRequest!)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        if let result = String(data: data, encoding: .utf8) {
                            configuration.resume(returning: result)
                        } else {
                            configuration.resume(throwing: NetworkError.unableToDecode)
                        }
                    case .failure(let error):
                        configuration.resume(throwing: error)
                    }
                }
        }
    }
}
