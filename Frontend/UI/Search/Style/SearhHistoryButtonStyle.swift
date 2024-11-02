//
//  SearhHistoryButtonStyle.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import Foundation
import SwiftUI

struct SearchHistoryButtonSTyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.Pretendard(size: 16, family: .Medium))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(Color(.cSurface), in: RoundedRectangle(cornerRadius: 15))
            .opacity(configuration.isPressed ? 0.8: 1)
    }
}
