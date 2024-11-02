//
//  SmallPolicyCell.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

struct SmallPolicyCell: View {
    var policy: RelevantPolicy
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(policy.name)
                .font(.Pretendard(size: 16, family: .SemiBold))
            Text(policy.description)
                .font(.Pretendard(size: 16, family: .Medium))
                .lineLimit(2)
        }
        .foregroundStyle(Color(.cOnSurface))
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .frame(height: 90, alignment: .top)
        .background(Color(.cSurface), in: RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    SmallPolicyCell(
        policy: RelevantPolicy(
            policyID: 1,
            name: "새로운 정책",
            description: "이것은 간단 사용 설명서",
            url: "",
            age: ""
        )
    )
}
