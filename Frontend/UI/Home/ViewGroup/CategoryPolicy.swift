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
                .onAppear {
                    viewModel.fetchPolicies(uuid: "your-uuid", category: selectedCategory.rawValue)
                }
            Spacer()
        }
    }
    
    private var categorySegment: some View {
        HStack(spacing: 10) {
            ForEach(policyCategory.allCases, id: \.self) { category in
                Button(action: {
                    selectedCategory = category
                    viewModel.fetchPolicies(uuid: "your-uuid", category: selectedCategory.rawValue)
                }) {
                    HStack {
                        Text("✨ \(category.toKorean())")
                            .font(.Pretendard(size: 16, family: .Bold))
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
    }
}

#Preview {
    CategoryPolicy()
}
