//
//  ClassPin.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import SwiftUI

struct ClassPin: View {
    var location: ClassLocation
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color(uiColor: UIColor(hex: location.color)))
            AsyncImage(url: URL(string: location.imageURL)) { content in
                content.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(5)
        }
        .frame(width: 75, height: 75)
    }
}

#Preview {
    ClassPin(location: ClassLocation(
        title: "싱글 벙글",
        color: "F5004F",
        imageURL: "https://www.incheonin.com/news/photo/202302/93856_134469_132.jpg",
        description: "1인가구 친구들을 만나보세요!",
        location: "종로구",
        latitude: 37.572442,
        longitude: 126.986727
    ))
}
