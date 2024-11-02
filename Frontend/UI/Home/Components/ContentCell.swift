//
//  ContentCell.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI

struct ContentCell: View {
    let data: HomeCategoryResponseData
    @State private var isSheetPresented: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            title
            content
            supplyBtn
        }
        .frame(width: 320, height: 111)
        .padding(11)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .sheet(isPresented: $isSheetPresented) {
            SheetView(data: data)
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
        }
    }

    private var title: some View {
        HStack {
            Text(data.name)
                .font(.Pretendard(size: 16, family: .Bold))
                .padding(.horizontal, 5)
            Spacer()
        }
    }

    private var content: some View {
        HStack {
            Text(data.description)
                .font(.Pretendard(size: 14, family: .Medium))
                .lineLimit(2)
                .padding(.horizontal, 5)
            Spacer()
        }
    }

    private var supplyBtn: some View {
        HStack {
            Spacer()
            CustomBtn(btnText: "지원하기", textColor: Color(.cPrimary), textSize: 13, width: 60, height: 30, action: {
                isSheetPresented = true
            }, innerColor: .cPrimaryContainer, outerColor: .cPrimary)
            .padding(.top, 3)
        }
    }
}

//MARK: - Preview
#Preview {
    ContentCell(data: HomeCategoryResponseData(
        policyId: 123,
        isScrapped: true,
        name: "청년취업사관학교",
        description: "서울시에서 SW인재 양성을 위해어쩌구 ~저ㅓ쩌구~ 2줄 넘어가는지 확인하자~",
        category: "JOB",
        age: "MIDDLE_AGED",
        url: "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png",
        applyUrl: "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png"
    ))
}
