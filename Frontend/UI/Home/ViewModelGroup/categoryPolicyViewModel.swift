//
//  categoryPolicyViewModel.swift
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
    
    // 정책 데이터 가져오기
    func fetchPolicies(uuid: String, category: String) {
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
                    print("✅ 데이터 성공적으로 불러옴: \(response.data)")
                }
            case .failure(let error):
                print("❌ 데이터 가져오는 중 오류 발생: \(error.localizedDescription)")
                if case .unableToDecode = error {
                    print("⚠️ 디코딩 실패, 응답 형식이 예상과 다릅니다.")
                } else if case .clientError = error {
                    print("⚠️ 클라이언트 오류 발생. 요청을 확인하세요.")
                } else if case .serverError = error {
                    print("⚠️ 서버 오류 발생. 서버 상태를 확인하세요.")
                } else {
                    print("⚠️ 기타 오류 발생: \(error)")
                }
            }
        }
    }
}
