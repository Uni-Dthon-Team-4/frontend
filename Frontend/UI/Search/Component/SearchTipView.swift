//
//  SearchTipView.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SearchTipView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("AI로 맞춤 정책 검색하기")
                    .font(.Pretendard(size: 12, family: .SemiBold))
                    .foregroundStyle(Color(uiColor: UIColor(hex: "006F7D")))
                Text("나에게 맞는 정책을 검색해보세요!")
                    .font(.Pretendard(size: 20, family: .Medium))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Image(.searchTip)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .background(Color(uiColor: UIColor(hex: "E5FCFF")), in: RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    SearchTipView()
}
