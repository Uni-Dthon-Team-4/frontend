//
//  KeywordButtonStyle.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation
import SwiftUI

struct KeywordButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.Pretendard(size: 16, family: .SemiBold))
            .foregroundStyle(Color(.cOnPrimary))
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .background(Color(.cPrimary), in: RoundedRectangle(cornerRadius: 15))
            .scaleEffect(CGSize(
                width: configuration.isPressed ? 0.95: 1,
                height: configuration.isPressed ? 0.95: 1
            ))
            .animation(.spring, value: configuration.isPressed)
    }
}
