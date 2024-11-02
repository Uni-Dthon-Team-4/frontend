//
//  CategoryPolicyViewModel.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Alamofire

@MainActor
class CategoryPolicyViewModel: ObservableObject {
    @Published var policies: [HomeCategoryResponseData] = []
    private let networkService = NetworkService.shared
    
    func fetchPolicies(category: String) async throws {
        let uuid = UserDefaultsManager.shared.getData(type: String.self, forKey: .uuid)
        guard !uuid.isEmpty else {
            print("UUID가 설정되어 있지 않습니다. 정책을 불러오지 않습니다.")
            return
        }
        
        print("✅ Fetched UUID from UserDefaults: \(uuid)")

        let request = HomeCategoryRequest(uuid: uuid, category: category)
        let target = HomeCategoryAPITarget.getPoliciesByAge(request)
        
        do {
            let urlRequest = try target.asURLRequest()
            print("Request URL: \(urlRequest.url?.absoluteString ?? "No URL")")
            print("Request Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
            print("Request Method: \(urlRequest.httpMethod ?? "No Method")")
        } catch {
            print("Failed to create URLRequest: \(error)")
            return
        }
        
        networkService.request(target) { [weak self] (result: Result<HomeCategoryResponse, NetworkError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.policies = response.data
                    print("데이터 성공적으로 불러옴: \(response.data)")
                }
            case .failure(let error):
                print("데이터 가져오는 중 오류 발생: \(error.localizedDescription)")
                
                if case .unableToDecode = error {
                    print("디코딩 실패, 응답 형식이 예상과 다릅니다.")
                    
                    
                }
            }
        }
    }
}
