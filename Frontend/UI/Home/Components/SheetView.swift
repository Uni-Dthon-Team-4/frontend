//
//  SheetView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//
import SwiftUI
import Kingfisher

struct SheetView: View {
    @State private var showWebView = false
    @State private var webURL: URL?
    let data: ContentData

    var body: some View {
        VStack(spacing: 15) {
            Text("더 알아보기")
                .font(.Pretendard(size: 18, family: .Bold))
                .padding(.top, 10)
            allContent
        }
        .sheet(isPresented: $showWebView) {
            if let webURL = webURL {
                SafariView(url: webURL)
            }
        }
    }

    private var allContent: some View {
        VStack(alignment: .leading, spacing: 15) {
            articleImage
            title
            content
            btnSet
        }
    }

    private var articleImage: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: data.image) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
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

    private var title: some View {
        Text(data.title)
            .font(.Pretendard(size: 16, family: .Bold))
            .frame(maxHeight: 22)
    }

    private var content: some View {
        VStack {
            Text(data.content)
                .font(.Pretendard(size: 16, family: .Medium))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(maxWidth: 353, maxHeight: 300)
    }

    private var btnSet: some View {
        HStack(spacing: 19) {
            CustomBtn(btnText: "자세히보기", textColor: .purple, textSize: 18, width: 167, height: 49, action: {
                if let url = URL(string: data.URL1) {
                    webURL = url
                    showWebView = true
                }
            }, innerColor: .indigo, outerColor: .purple)

            CustomBtn(btnText: "신청하기", textColor: .purple, textSize: 18, width: 167, height: 49, action: {
                if let url = URL(string: data.URL2) {
                    webURL = url
                    showWebView = true
                }
            }, innerColor: .white, outerColor: .purple)
        }
    }
}

#Preview {
    SheetView(data: ContentData(category: .job, id: 1, title: "청년취업사관학교", content: "서울시에서 SW인재 양성을 위해…", image: "https://1in.seoul.go.kr/images/front/img_policyInformation2.png", URL1: "https://www.naver.com", URL2: "https://www.google.com"))
}
