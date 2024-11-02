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
    
    let data: HomeData
    
    var body: some View {
        
            Text("나를 위한 정책")
                .font(.Pretendard(size: 22, family: .Bold))
                .frame(alignment: .leading)
                .padding(.trailing, 200)
        
        
        article
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
    
    
    private var article: some View {
        ZStack(alignment: .bottomLeading){
            
            
            if let url = URL(string: data.image) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .frame(width: 355, height: 216)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                    )
            }
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.86), Color.black.opacity(0.2)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 355, height: 216)
            
            articleTitle
                .padding(10)
        }
        
    }
}

#Preview {
    HomeView(data: HomeData(id: 1123, image: "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"))
}
