//
//  BaseAPI.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import Foundation
import Alamofire

protocol BaseAPI: URLRequestConvertible {
    associatedtype Response: Decodable
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams? { get }
    var headers: HTTPHeaders? { get }
}

extension BaseAPI {
    var baseURL: String { "https://coherent-midge-probably.ngrok-free.app/" }
    var method: HTTPMethod { .get }
    var path: String { "" }
    var parameters: RequestParams? { nil }
    var headers: HTTPHeaders? { nil }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue("", forHTTPHeaderField: "ngrok-skip-browser-warning")
        
        // 기본 헤더 설정
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderType.contentType.rawValue)
        
        // 사용자 정의 헤더가 있는 경우 추가
        if let headers = headers {
            headers.dictionary.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        
        // 파라미터 설정
        if let parameters = parameters {
            switch parameters {
            case .query(let request):
                var params = request?.toDictionary() ?? [:]
                // 배열 파라미터 처리
                for (key, value) in params {
                    if let arrayValue = value as? [String] {
                        let joinedValue = arrayValue.joined(separator: ",")
                        params[key] = joinedValue
                    }
                }
                
                // URL에 쿼리 파라미터 추가
                var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
                components?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                urlRequest.url = components?.url
                
            case .body(let request):
                let params = request?.toDictionary() ?? [:]
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        
        return urlRequest
    }
}

enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
