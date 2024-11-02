//
//  MyPolicy.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

struct MyPolicy: View {
    @StateObject private var viewModel = MyPolicyViewModel()
    @State private var isSheetPresented: Bool = false
    private let keyword: String
    
    init(keyword: String = UserDefaults.standard.string(forKey: "userKeyword") ?? "청년") {
        self.keyword = keyword
    }
    
    var body: some View {
        VStack(spacing: 25) {
            titleAndArticle
            if !viewModel.policies.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.policies) { policy in
                            policyView(for: policy)
                        }
                    }
                }
            } else {
                Text("정책 데이터를 찾을 수 없습니다.")
                    .font(.Pretendard(size: 16, family: .Medium))
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .frame(maxWidth: 357)
        .onAppear {
            Task {
                await viewModel.fetchPolicies(keyword: keyword)
            }
        }
    }
    
    /// Main title and article button
    private var titleAndArticle: some View {
        VStack(spacing: 31) {
            topTitle
        }
    }

    /// Top title
    private var topTitle: some View {
        HStack {
            Text("나를 위한 정책")
                .font(.Pretendard(size: 24, family: .Bold))
            Spacer()
        }
    }

    /// Individual policy view
    private func policyView(for policy: HomeMyPolicyResponseData) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(policy.name)
                    .font(.Pretendard(size: 16, family: .Bold))
                Spacer()
            }
            HStack {
                Text(policy.description)
                    .font(.Pretendard(size: 14, family: .Medium))
                    .lineLimit(2)
                Spacer()
            }
            HStack {
                Spacer()
                Button(action: {
                    if let url = URL(string: policy.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("자세히 보기")
                        .font(.Pretendard(size: 13))
                        .padding(10)
                        .background(Color.purple.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//MARK: - Preview
struct MyPolicy_Preview: PreviewProvider {
    static var previews: some View {
        MyPolicy()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
