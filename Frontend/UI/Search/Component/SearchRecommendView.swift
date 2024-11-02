//
//  SearchRecommendView.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SearchRecommendView: View {
    @Environment(SearchViewModel.self) private var viewmodel
    
    var body: some View {
        VStack(alignment: .leading) {
            if !viewmodel.isCacheExist {
                SearchTipView()
                    .padding(EdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 18))
            }
            if !viewmodel.previousSearches.isEmpty {
                RecommendSection(header: "지난 질문") {
                    ForEach(viewmodel.previousSearches, id: \.self) { search in
                        Button(search, action: { searchByHistory(history: search) })
                            .buttonStyle(SearchHistoryButtonSTyle())
                    }
                }
            }
            if !viewmodel.previousPolicies.isEmpty {
                RecommendHScrollSection(header: "확인한 정책") {
                    ForEach(viewmodel.previousPolicies, id:\.self) { policy in
                        SmallPolicyCell(policy: policy)
                    }
                }
            }
        }
    }
    
    private func searchByHistory(history: String) {
        viewmodel.text=history
        viewmodel.search()
    }
}

fileprivate struct RecommendSection<Content: View>: View {
    var header: String
    var content: ()->Content
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(header)
                .font(.Pretendard(size: 16, family: .SemiBold))
                .foregroundStyle(Color(.cOnSurface))
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(subviews: content()) { subview in
                    subview
                }
            }
        }
        .padding(EdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 18))
    }
}

fileprivate struct RecommendHScrollSection<Content: View>: View {
    var header: String
    var content: ()->Content
    
    init(header: String, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(header)
                .font(.Pretendard(size: 16, family: .SemiBold))
                .foregroundStyle(Color(.cOnSurface))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 5, leading: 18, bottom: 5, trailing: 18))
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(subviews: content()) { subview in
                        subview
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.never)
            .scrollTargetBehavior(.viewAligned)
            .frame(height: 104)
            .contentMargins(.horizontal, 18, for: .scrollContent)
        }
    }
}

#Preview {
    SearchRecommendView()
        .environment(SearchViewModel())
}
