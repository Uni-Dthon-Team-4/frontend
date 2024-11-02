//
//  SearchView.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SearchView: View {
    @State private var viewmodel = SearchViewModel()
    private let vSpacing: CGFloat = 12
    
    var body: some View {
        GeometryReader { proxy in
            let cellHeight = proxy.size.height-(proxy.safeAreaInsets.top+vSpacing)
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: vSpacing) {
                    Text("맞춤 정책 찾아보기")
                        .font(.Pretendard(size: 24, family: .Bold))
                        .foregroundStyle(.cOnSurface)
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1: 0)
                        }
                    if viewmodel.results.isEmpty {
                        SearchRecommendView()
                    }
                    ForEach(viewmodel.results) { result in
                        SearchResultCell(result: result)
                            .frame(height: cellHeight, alignment: .top)
                            .id(result.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $viewmodel.currentResult, anchor: .top)
            .background(.cSurfaceDim)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)
            .safeAreaInset(edge: .bottom, spacing: 5) {
                SearchTextField(text: $viewmodel.text)
            }
            .environment(viewmodel)
        }
        .onAppear {
            viewmodel.loadCache()
        }
        .onDisappear {
            viewmodel.saveCache()
        }
    }
}

#Preview {
    SearchView()
}
