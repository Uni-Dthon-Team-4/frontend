//
//  MyPolicy.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI
import Kingfisher

struct MyPolicy: View {
    @EnvironmentObject private var viewModel: MyPolicyViewModel
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            titleAndArticle
            if let data = viewModel.randomPolicy {
                articleLabel(data: data)
                    .transition(.push(from: .top))
                    .onTapGesture {
                        isSheetPresented = true
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        if let url = URL(string: data.url) {
                            SafariView(url: url)
                        }
                    }
                
                if let ageGroup = ageEnum(rawValue: data.age) {
                    ageImage(for: ageGroup)
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut, value: viewModel.randomPolicy)
    }
    
    private var titleAndArticle: some View {
        VStack(spacing: 31) {
            HStack {
                Text("나를 위한 정책")
                    .font(.Pretendard(size: 24, family: .Bold))
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func articleLabel(data: HomeMyPolicyResponseData) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("도움이 되는 뉴스")
                    .font(.Pretendard(size: 12, family: .SemiBold))
                    .foregroundColor(Color(.cOnPrimaryContainer))
                
                Text(data.name)
                    .font(.Pretendard(size: 20, family: .SemiBold))
                    .foregroundColor(Color(.cOnSurface))
                    .lineLimit(1)
                    .contentTransition(.numericText())
                Text(data.description)
                    .font(.Pretendard(size: 14, family: .Medium))
                    .foregroundColor(Color(.cOnSurface))
                    .lineLimit(1)
                    .contentTransition(.opacity)
            }
            .animation(.snappy, value: data)
            Spacer()
            Image("News")
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding(6)
        .padding(.horizontal, 4)
        .background(Color(.cPrimaryContainer))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func ageImage(for ageGroup: ageEnum) -> some View {
        Image(ageGroup.imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 125)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Preview
#Preview {
    MyPolicy()
        .environmentObject(MyPolicyViewModel())
}
