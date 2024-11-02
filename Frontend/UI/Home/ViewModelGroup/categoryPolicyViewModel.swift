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
        networkService.request(HomeCategoryAPITarget.getPoliciesByAge(request)) { [weak self] (result: Result<HomeCategoryResponse, NetworkError>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.policies = response.data
                }
            case .failure(let error):
                print("Error fetching or decoding data: \(error.localizedDescription)")
            }
        }
    }
}
