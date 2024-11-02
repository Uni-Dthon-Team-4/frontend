//
//  TempFontStyle.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/2/24.
//

import SwiftUI

extension Font {
    static func Pretendard(size: CGFloat = 14, family: UIFont.Family) -> Font {
        Font.custom("Pretendard-\(family)", fixedSize: size)
    }
}
