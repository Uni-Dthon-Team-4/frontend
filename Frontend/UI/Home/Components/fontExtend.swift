//
//  fontExtend.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUICore
import UIKit

extension Font {
    static func Pretendard(size: CGFloat = 14, family: UIFont.Family = .Regular) -> Font {
            return Font.custom("Pretendard-\(family.rawValue)", size: size)
        }
}
