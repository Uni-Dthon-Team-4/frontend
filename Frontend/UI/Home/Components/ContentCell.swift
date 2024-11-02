//
//  ContentCell.swift
//  Frontend
//
//  Created by 한지강 on 11/2/24.
//

import SwiftUI

struct ContentCell: View {
    let data : ContentData
    var body: some View {
        VStack{
            title
            policyLocation
        }
    }
    
    private var title: some View{
        VStack {
            Text(data.title)
            Text(data.content)
        }
    }
    private var policyLocation: some View {
        HStack{
            
        }
    }
    
    
    //정책 타이틀
    //content
    //location
}

#Preview {
    ContentCell(data: ContentData(category: "전체", id: 123, title: "정책 타이틀", content: " 한줄설명한줄설명 한 줄 설 명", image:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL1:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", URL2:  "https://youth.gg.go.kr/_attach/gg/editor-image/2023/02/JZPCyzESBWoBWTqKjfINNWWwbm.png", location: "서울시"))
}
