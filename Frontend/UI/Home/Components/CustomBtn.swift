//
//  CustomBtn.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI

struct CustomBtn: View {
    
    var btnText: String
    var textColor: Color
    var textSize: CGFloat
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    var innerColor: Color
    var outerColor: Color

    init(btnText: String,
         textColor: Color,
         textSize: CGFloat,
         width: CGFloat,
         height: CGFloat,
         action: @escaping () -> Void,
         innerColor: Color,
         outerColor: Color
    ) {
        self.btnText = btnText
        self.textColor = textColor
        self.textSize = textSize
        self.width = width
        self.height = height
        self.action = action
        self.innerColor = innerColor
        self.outerColor = outerColor
    }
    
    //MARK: - Contents
    /// 버튼 기본적인 구조
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(btnText)
                .frame(width: width, height: height)
                .font(.Pretendard(size: textSize, family: .Medium))
                .foregroundStyle(textColor)
                .background(innerColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(outerColor)
                    .fill(Color.clear)
                    .frame(width: width, height: height)
                    
                )
               
        })
    }
}

//MARK: - Preiview
struct MainButton_Preview: PreviewProvider {
    static var previews: some View {
        CustomBtn(btnText: "신청하기", textColor: .purple, textSize: 18, width: 167, height: 49, action: {print("hello")}, innerColor: .white, outerColor: .purple)
            .previewLayout(.sizeThatFits)
    }
}
