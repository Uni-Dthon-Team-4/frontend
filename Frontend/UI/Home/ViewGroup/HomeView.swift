//
//  HomeView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//
import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject private var myPolicyViewModel = MyPolicyViewModel()
    @StateObject private var categoryPolicyViewModel = CategoryPolicyViewModel()

    var body: some View {
        ScrollView {
            VStack {
                MyPolicy()
                    .environmentObject(myPolicyViewModel) // MyPolicy에 ViewModel 주입
                    .onAppear {
                        myPolicyViewModel.fetchPolicies(keyword: "청년")
                    }
                
                CategoryPolicy()
                    .environmentObject(categoryPolicyViewModel) // CategoryPolicy에 ViewModel 주입
                    .onAppear {
                        Task {
                            try? await categoryPolicyViewModel.fetchPolicies(uuid: "d93bd8f4-39b4-42e6-8aa3-77db9f6429da", category: "JOB")
                        }
                    }
            }
        }
        .frame(maxWidth: 357)
        .refreshable {
            // 새로고침 시 데이터 다시 가져오기
            myPolicyViewModel.fetchPolicies(keyword: "청년")
            Task {
                try? await categoryPolicyViewModel.fetchPolicies(uuid: "d93bd8f4-39b4-42e6-8aa3-77db9f6429da", category: "JOB")
            }
        }
    }
}

//MARK: - Preview
struct HomeView_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 15 Pro", "iPhone 15 Pro Max"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView(
            )
            .previewDevice(PreviewDevice(rawValue: device))
            .previewDisplayName(device)
        }
    }
}
