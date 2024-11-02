//
//  Font+.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import SwiftUI

extension Font {
    static func Pretendard(size: CGFloat = 14, family: UIFont.Family = .Regular) -> Font {
        return Font.custom("Pretendard-\(family.rawValue)", size: size)
    }
}
