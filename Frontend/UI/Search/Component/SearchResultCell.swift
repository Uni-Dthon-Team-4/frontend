//
//  SearchResultCell.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SearchResultCell: View {
    var result: SearchResult
    private var markdownMessage: AttributedString? {
        try? AttributedString(markdown: result.message, options: .init(allowsExtendedAttributes: true, interpretedSyntax: .inlineOnlyPreservingWhitespace))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(result.search)
                    .font(.Pretendard(size: 16, family: .Medium))
                if result.isError {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(Color(.cError))
                }
            }
            Divider()
            HStack(spacing: 5) {
                Image(systemName: "wand.and.stars.inverse")
                Text("AI에 의해 생성된 답변입니다.")
            }
            .font(.Pretendard(size: 12, family: .SemiBold))
            .foregroundStyle(Color(uiColor: UIColor(hex: "64008B")))
            Group {
                if let markdownMessage {
                    Text(markdownMessage)
                } else {
                    Text(result.message)
                }
            }
            .multilineTextAlignment(.leading)
            .contentTransition(.numericText())
            .animation(.easeInOut, value: result.message)
            .font(.Pretendard(size: 16, family: .Regular))
            if result.isLoading {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .background()
    }
}

#Preview {
    SearchResultCell(
        result: SearchResult(
            isError: false, isLoading: false,
            search: "맏춤 정책 추천해줘",
            message: """
### 서울시는 1인가구를 위해 다양한 지원 정책을 제공하고 있습니다. 주요 프로그램은 다음과 같습니다: \n

1. **병원 안심동행 서비스**: 혼자 병원 방문이 어려운 시민을 위해 동행 매니저가 병원 출발부터 귀가까지 동행하며 접수, 수납, 약품 수령 등을 지원합니다. 이용료는 시간당 5,000원이며, 중위소득 100% 이하 시민은 연간 48회까지 무료로 이용할 수 있습니다. (Seoul News)\n

2. 전월세 안심계약 도움서비스: 부동산 계약에 익숙하지 않은 1인가구를 위해 주거안심매니저가 전월세 계약 상담과 집보기 동행 등의 도움을 제공합니다. 평일뿐만 아니라 토요일에도 시범 운영하여 직장인들의 이용 편의를 높이고 있습니다. (Seoul News)\n

이 외에도 서울시는 1인가구의 생활 안정을 위해 다양한 정책을 추진하고 있습니다. 자세한 내용은 서울시 1인가구 포털 ‘씽글벙글 서울’에서 확인하실 수 있습니다. 
"""
        )
    )
}
