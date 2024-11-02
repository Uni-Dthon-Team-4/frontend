//
//  SheetView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

struct SheetView: View {
    let data: ContentData
    
    var body: some View {
        VStack(spacing: 15){
            Text("더 알아보기")
                .font(.Pretendard(size: 18,family: .Bold))
            allContent
        }
    }
    
    private var allContent: some View {
        VStack(alignment: .leading, spacing: 15){
            articleImage
            title
            content
            btnSet
        }
    }
    
    
    //image
    
    private var articleImage: some View {
        ZStack(alignment: .bottomLeading){
            
            
            if let url = URL(string: data.image) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(width: 355, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                    )
            }
        }
        
    }
    
//    private var titleAndContent: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            title
//            content
//        }
//    }
    
    private var title: some View {
        
        Text(data.title)
            .font(.Pretendard(size: 16, family: .Bold))
            .frame(maxHeight: 22)
            
            
    }
    
    private var content: some View {
        VStack{
            Text(data.content)
                .font(.Pretendard(size: 16, family: .Medium))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(maxWidth: 353, maxHeight: 300)
    }
    
    private var btnSet: some View {
        HStack(spacing: 19){
            CustomBtn(btnText: "자세히보기", textColor: .purple, textSize: 18, width: 167, height: 49, action: {print("hello")}, innerColor: .indigo, outerColor: .purple)
            
            CustomBtn(btnText: "신청하기", textColor: .purple, textSize: 18, width: 167, height: 49, action: {print("hello")}, innerColor: .white, outerColor: .purple)
            
        }
    }
}

#Preview {
    SheetView(data: ContentData(category: policyCategory.job, id: 123, title: "청년취업사관학교", content: "한줄설명한줄설명 한 줄 설 명 한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명ㅁㄴ어ㅜㅁㄴ아ㅓ무너ㅏ움나ㅓ운머ㅏ우나머", image:  "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL2:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"))
    }

