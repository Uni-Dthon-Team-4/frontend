//
//  HomeView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    let data: ContentData
    
    var body: some View {
        ScrollView {
            VStack {
                MyPolicy(data: data)
                
                CategoryPolicy()
            }
        }
        .frame(maxWidth: 357)
        
        //TODO: - refesh API
//        .refreshable {
//            
//        }
//        .onAppear {
//            
//        }
    }
    
    // 샘플 데이터
    private var sampleContentData: [ContentData] {
        [
            ContentData(category: .job, id: 1, title: "청년취업사관학교", content: "서울시에서 SW인재 양성을 위해…", image: "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1: "", URL2: ""),
            ContentData(category: .education, id: 2, title: "교육지원 프로그램", content: "교육 프로그램에 대한 소개…", image: "", URL1: "", URL2: "")
        ]
    }
}

#Preview {
    HomeView(data: ContentData(category: .job, id: 1, title: "청년취업사관학교", content: "서울시에서 SW인재 양성을 위해...", image: "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1: "", URL2: ""))
}
