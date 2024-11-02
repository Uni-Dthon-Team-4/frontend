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
    let data: HomeCategoryResponseData

    var body: some View {
        VStack(spacing: 15) {
            Text("더 알아보기")
                .font(.Pretendard(size: 18, family: .Bold))
                .padding(.top, 15)
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
        .frame(maxWidth: 353)
    }

    private var articleImage: some View {
        ZStack(alignment: .bottomLeading) {
            if let ageGroup = ageEnum(rawValue: data.age) {
                Image(ageGroup.imageName)
                    .resizable()
                    .frame(width: 355, height: 125)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.clear)
                    )
            } else if let url = URL(string: data.url) {
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
        Text(data.name)
            .font(.Pretendard(size: 16, family: .Bold))
            .frame(maxHeight: 22)
    }

    private var content: some View {
        VStack {
            Text(data.description)
                .font(.Pretendard(size: 16, family: .Medium))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(maxWidth: 353, maxHeight: 300)
    }

    private var btnSet: some View {
        HStack(spacing: 19) {
            CustomBtn(btnText: "자세히보기", textColor: .white, textSize: 18, width: 167, height: 49, action: {
                if let url = URL(string: data.url) {
                    webURL = url
                    showWebView = true
                }
            }, innerColor: .cPrimary, outerColor: .cPrimary)

            CustomBtn(btnText: "신청하기", textColor: .cPrimary, textSize: 18, width: 167, height: 49, action: {
                if let url = URL(string: data.applyUrl) {
                    webURL = url
                    showWebView = true
                }
            }, innerColor: Color(.cPrimaryContainer), outerColor: .cPrimary)
        }
    }
}

#Preview {
    SheetView(data: HomeCategoryResponseData(
        policyId: 123,
        isScrapped: true,
        name: "청년취업사관학교",
        description: "서울시에서 SW인재 양성을 위해...",
        category: "JOB",
        age: "MIDDLE_AGED",
        url: "https://www.naver.com",
        applyUrl: "https://www.google.com"
    ))
}
