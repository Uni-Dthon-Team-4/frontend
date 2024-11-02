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
    @Published var randomPolicy: HomeMyPolicyResponseData? 
    
    private let provider = NetworkService.shared

    // 정책 목록을 불러오는 메서드
    func fetchPolicies() {
        let keyword1 = UserDefaults.standard.string(forKey: "keyword1") ?? ""
        let keyword2 = UserDefaults.standard.string(forKey: "keyword2") ?? ""
        let keyword3 = UserDefaults.standard.string(forKey: "keyword3") ?? ""
        
        let keyword = !keyword1.isEmpty ? keyword1 : (!keyword2.isEmpty ? keyword2 : keyword3)
        
        guard !keyword.isEmpty else {
            return
        }
        
        let request = HomeMyPolicyRequest(keyword: keyword)
        
        provider.request(HomeMyPolicyAPITarget.searchPolicies(request)) { [weak self] result in
            switch result {
            case .success(let response):
                Task {
                    self?.policies = response.data
                    self?.selectRandomPolicy()
                }
            case .failure(let error):
                print("Error fetching policies: \(error.localizedDescription)")
            }
        }
    }
    
    private func selectRandomPolicy() {
        randomPolicy = policies.randomElement()
    }
    
    func refreshRandomPolicy() {
        selectRandomPolicy()
    }
}
