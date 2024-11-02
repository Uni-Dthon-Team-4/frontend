//
//  MyPolicy.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

struct MyPolicy: View {
    @State private var isSheetPresented: Bool = false
    
    let data: ContentData
    
    
    //MARK: - Contents
    var body: some View {
        VStack(spacing: 25){
            titleAndArticle
            image
            
            Spacer()
        }
        .frame(maxWidth: 357)
    }
    
    /// 맨의 나를 위한정책글자와 뉴스
    private var titleAndArticle: some View{
        VStack(spacing: 31){
            topTitle
            articleBtn
        }
    }
    
    
    /// 위에 타이틀 글자
    private var topTitle: some View {
        HStack{
            Text("나를 위한 정책")
                .font(.Pretendard(size: 24, family: .Bold))
            Spacer()
        }
    }
    
    
    /// 기사누르면 웹뷰뜨도록 해야함
    private var articleBtn: some View {
            Button(action: { isSheetPresented = true }) {
                articleLabel
            }
            .sheet(isPresented: $isSheetPresented) {
                      if let url = URL(string: data.URL1) {
                          SafariView(url: url)
                      }
                  }
        }
    
    /// 뉴스 내용담고 있는 텍스트들
    private var articleLabel: some View {
     
        HStack{
            VStack(spacing: 5){
                benefitNews
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
    
    
    
    /// 도움이 되는 뉴스
    private var benefitNews: some View {
        HStack{
            Text("도움이 되는 뉴스")
                .font(.Pretendard(size: 12, family: .SemiBold))
            Spacer()
        }
        
        
    }
    
    /// 뉴스 제목
    private var title: some View{
        HStack {
            Text(data.title)
                .font(.Pretendard(size: 20, family: .SemiBold))
            Spacer()
         
        }
    }
    
    /// 뉴스 내용
    private var content: some View{
        HStack{
            Text(data.content)
                .font(.Pretendard(size: 14, family: .Medium))
                .lineLimit(1)
            Spacer()
        }
        
    }
    
    
    /// 아래 청년, 노년 등에 대한 이미지
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


//MARK: - Preview
#Preview {
    MyPolicy(data: ContentData(category: policyCategory.job, id: 123, title: "청년취업사관학교", content: "한줄설명한줄설명 한 줄 설 명 한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명한 줄 설 명ㅁㄴ어ㅜㅁㄴ아ㅓ무너ㅏ움나ㅓ운머ㅏ우나머", image:  "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL2:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"))
    }

