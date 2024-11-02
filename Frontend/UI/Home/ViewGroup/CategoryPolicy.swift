//
//  CategoryPolicy.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//
import SwiftUI

struct CategoryPolicy: View {
    @StateObject private var viewModel = CategoryPolicyViewModel()
    @State private var selectedCategory: policyCategory = .job
    
    var body: some View {
        VStack {
            categorySegment
            policyList
                .task {
                    // View가 나타날 때 기본 데이터를 로드
                    await fetchData()
                }
            Spacer()
        }
    }
    
    private func fetchData() async {
        do {
            try await viewModel.fetchPolicies(uuid: "d93bd8f4-39b4-42e6-8aa3-77db9f6429da", category: selectedCategory.rawValue)
        } catch {
            print("❌ 데이터 로드 중 오류 발생: \(error.localizedDescription)")
        }
    }

    private var categorySegment: some View {
        HStack(spacing: 10) {
            ForEach(policyCategory.allCases, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    Task {
                        await fetchData()
                    }
                }) {
                    HStack {
                        Text("✨ \(category.toKorean())")
                            .font(.Pretendard(size: 16, family: .Medium))
                            .foregroundColor(selectedCategory == category ? .white : .black)
                            .padding(.horizontal, 13)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(selectedCategory == category ? Color.cPrimary : Color.cSurfaceContainer)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.cPrimary, lineWidth: selectedCategory == category ? 0.1 : 0)
                            )
                    }
                }
            }
        }
    }
    
    private var policyList: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
            ForEach(viewModel.policies) { data in
                ContentCell(data: data)
            }
        }
        .onAppear {
            print("📊 ViewModel에 로드된 데이터 수: \(viewModel.policies.count)")
        }
    }
}

#Preview {
    CategoryPolicy()
}
