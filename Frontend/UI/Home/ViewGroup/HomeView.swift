//
//  HomeView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

extension Font {
    static func Pretendard(size: CGFloat = 14, family: UIFont.Family = .Regular) -> Font {
            return Font.custom("Pretendard-\(family.rawValue)", size: size)
        }
}



struct HomeView: View {
    
    let data: ContentData
    
    var body: some View {
        VStack(spacing: 25){
            titleAndArticle
            image
        }
        .frame(maxWidth: 357)
    }
    
    
    
    /// 맨의 나를 위한정책과 밑에 뉴스
    private var titleAndArticle: some View{
        VStack(spacing: 31){
            topTitle
            articlePreview
        }
    }
    
    
    private var topTitle: some View {
        HStack{
            Text("나를 위한 정책")
                .font(.Pretendard(size: 24, family: .Bold))
            Spacer()
        
        }
    }
    
    
    /// 뉴스 내용
    private var articlePreview: some View {
        HStack{
            VStack(spacing: 5){
                myPolicy
                title
                content
            }
            Image("News")
            
        }
        .frame(width: 335, height: 89)
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    
    
    private var myPolicy: some View {
        HStack{
            Text("도움이 되는 뉴스")
                .font(.Pretendard(size: 12, family: .SemiBold))
            Spacer()
        }
        
        
    }
    
    private var title: some View{
        HStack {
            Text(data.title)
                .font(.Pretendard(size: 20, family: .SemiBold))
            Spacer()
         
        }
    }
    
    private var content: some View{
        HStack{
            Text(data.content)
                .font(.Pretendard(size: 14, family: .SemiBold))
                .lineLimit(1)
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
    
    
   
    
    
    
    
    
    
    private var articleTitle: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("기사 타이틀")
                .font(.Pretendard(size: 24, family: .Bold))
                .foregroundStyle(.white)
            Text("기사 내용,기사 내용,기사 내용,기사 내용")
                .font(.Pretendard(size: 16, family: .SemiBold))
                .foregroundStyle(.white)
        }
            
    }
    
    
    private var image: some View {
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
}


#Preview {
    HomeView(data: ContentData(category: policyCategory.job, id: 123, title: "청년취업사관학교", content: "한줄설명한줄설명 한 줄 설 명 한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명ㅁㄴ어ㅜㅁㄴ아ㅓ무너ㅏ움나ㅓ운머ㅏ우나머", image:  "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL2:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"))
    }

