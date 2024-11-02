//
//  SheetView.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//
import SwiftUI
import Alamofire

struct SheetView: View {
    @State private var showWebView = false
    @State private var webURL: URL?
    @State private var descriptionText: String = "로딩 중입니다..."
    
    private let networkService = NetworkService.shared
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
        .onAppear {
            fetchPolicyDescription()
        }
    }
    private func fetchPolicyDescription() {
        let target = HomeAiAPITarget.getPolicyDescription(policyName: data.name)
        
        AF.request(target.urlRequest!)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let description = String(data: data, encoding: .utf8) {
                        descriptionText = description
                    } else {
                        descriptionText = "정책 설명을 불러오는 중 오류가 발생했습니다."
                        print("데이터 변환 오류: 문자열로 변환할 수 없습니다.")
                    }
                case .failure(let error):
                    descriptionText = "정책 설명을 불러오는 중 오류가 발생했습니다."
                    print("오류 발생: \(error.localizedDescription)")
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
            Text(descriptionText) // 받아온 설명을 표시
                .font(.Pretendard(size: 16, family: .Medium))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .frame(maxWidth: 353, maxHeight: 300)
    }

    private var btnSet: some View {
        HStack(spacing: 19) {
            if let url = URL(string: data.url) {
                CustomBtn(btnText: "자세히보기", textColor: .white, textSize: 18, width: data.applyUrl == "" ? 353 : 167, height: 49, action: {
                    webURL = url
                    showWebView = true
                }, innerColor: .cPrimary, outerColor: .cPrimary)
            }
            
            if let applyUrl = URL(string: data.applyUrl) {
                CustomBtn(btnText: "신청하기", textColor: .cPrimary, textSize: 18, width: data.url == "" ? 353 : 167, height: 49, action: {
                    webURL = applyUrl
                    showWebView = true
                }, innerColor: Color(.cPrimaryContainer), outerColor: .cPrimary)
            }
        }
        .frame(maxWidth: 353)
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
