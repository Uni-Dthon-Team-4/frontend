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
                    .environmentObject(myPolicyViewModel)
                
                CategoryPolicy()
                    .environmentObject(categoryPolicyViewModel)
                    .onAppear {
                        Task {
                            try? await categoryPolicyViewModel.fetchPolicies(category: "JOB")
                        }
                    }
            }
        }
        .contentMargins(.horizontal, 18, for: .scrollContent)
        .onAppear {
            myPolicyViewModel.fetchPolicies()
        }
        .refreshable {
                    myPolicyViewModel.fetchPolicies()
                    Task {
                        try? await categoryPolicyViewModel.fetchPolicies(category: "JOB")
                    }
                    myPolicyViewModel.objectWillChange.send()
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
