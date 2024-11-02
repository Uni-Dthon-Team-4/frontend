//
//  CategoryPolicy.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI

struct CategoryPolicy: View {
    @State private var selectedCategory: policyCategory = .job
    let contentData: [ContentData] = [
           ContentData(category: .job, id: 1, title: "청년취업사관학교", content: "서울시에서 SW인재 양성을 위해…", image: "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1: "", URL2: ""),
           ContentData(category: .education, id: 2, title: "교육지원 프로그램", content: "교육 프로그램에 대한 소개…", image: "", URL1: "", URL2: ""),

       ]
    
    var body: some View {
        VStack {
            categorySegment
            policyList
            Spacer()
        }
    }
    
    private var categorySegment: some View {
        HStack(spacing: 10) {
                ForEach(policyCategory.allCases, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        HStack {
                            Text("✨ \(category.toKorean())")
                                .font(.Pretendard(size: 16, family: .Bold))
                                .foregroundColor(selectedCategory == category ? .white : .black)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(selectedCategory == category ? Color.purple : Color.gray.opacity(0.1))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.purple, lineWidth: selectedCategory == category ? 2 : 0)
                                )
                        }
                }
            }
        }
        
    }
    
    private var policyList: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 16) {
            ForEach(filteredContent) { data in
                ContentCell(data: data)
            }
        }
    }
    
    private var filteredContent: [ContentData] {
        contentData.filter { $0.category == selectedCategory }
    }
    
    
    
    
}

#Preview {
    CategoryPolicy()
}
