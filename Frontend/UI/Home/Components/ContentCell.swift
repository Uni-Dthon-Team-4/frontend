//
//  ContentCell.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI

struct ContentCell: View {
    
//    var btnText: String
//    var textSize: CGFloat
//    var width: CGFloat
//    var height: CGFloat
//    var action: () -> Void
//    var innerColor: Color
//    
//    init(btnText: String,
//         textSize: CGFloat,
//         width: CGFloat,
//         height: CGFloat,
//         action: @escaping () -> Void,
//         innerColor: Color
//    ) {
//        self.btnText = btnText
//        self.textSize = textSize
//        self.width = width
//        self.height = height
//        self.action = action
//        self.innerColor = innerColor
//    }
    
    
    let data : ContentData
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            title
            content
            supplyBtn
        }
        .frame(width: 320, height: 111)
        .padding(11)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
    }
    
    private var title: some View{
        HStack {
            Text(data.title)
                .font(.Pretendard(size: 16, family: .Bold))
                .padding(.horizontal,5)
            Spacer()
         
        }
    }
    
    private var content: some View{
        HStack{
            Text(data.content)
                .font(.Pretendard(size: 14, family: .Medium))
                .lineLimit(2)
                .padding(.horizontal,5)
            Spacer()
        }
        
    }
    
    
    
    private var supplyBtn: some View {
        HStack {
            Spacer()
            CustomBtn(btnText: "지원하기", textColor: .black, textSize: 13, width: 60, height: 30, action: {print("지우너하기")}, innerColor: .white, outerColor: .purple)
                .padding(.top,3)
            
        }
    }
    
    
   
    
}

#Preview {
    ContentCell(data: ContentData(category: policyCategory.job, id: 123, title: "청년취업사관학교", content: " 한줄ㄴㅁ아ㅣㅁㅁㄴ아dkdklamdkdksusdgktpdy 안녕하세요 저는 한지강입니다. 내 잘 부탁드립ㄴ다. 안녕하세요 저는 ", image:  "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL2:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"))
}
