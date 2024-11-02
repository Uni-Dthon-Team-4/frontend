//
//  MyPolicyViewModel.swift
//  Frontend
//
//  Created by 한지강 on 11/3/24.
//
import SwiftUI
import Alamofire

@MainActor
class MyPolicyViewModel: ObservableObject {
    @Published var policies: [HomeMyPolicyResponseData] = []
    
    private let provider = NetworkService.shared
    
    var randomPolicy: HomeMyPolicyResponseData? {
        policies.randomElement()
    }

    func fetchPolicies(keyword: String) {
        let request = HomeMyPolicyRequest(keyword: keyword)
        
        provider.request(HomeMyPolicyAPITarget.searchPolicies(request)) { [weak self] result in
            switch result {
            case .success(let response):
                Task {
                    self?.policies = response.data
                }
            case .failure(let error):
                print("Error fetching policies: \(error.localizedDescription)")
            }
        }
    }
}
