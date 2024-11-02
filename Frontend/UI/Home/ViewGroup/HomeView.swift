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
    //MARK: - Contents
    var body: some View {
        ScrollView {
            VStack {
                MyPolicy()
                
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
}


//MARK: - Preview
struct QnaTipsView_Preview: PreviewProvider {

    static let devices = ["iPhone 11", "iPhone 15 Pro", "iPhone 15 Pro Max"]

    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            HomeView(data: ContentData(category: .job, id: 1, title: "청년취업사관학교", content: "서울시에서 SW인재 양성을 위해어쩌구 저쩌구 글을 넣어보자~...", image: "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1: "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=청년취업사관학교", URL2: ""))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
