//
//  ClassLocation.swift
//  Frontend
//
//  Created by Jaeho Lee on 11/3/24.
//

import Foundation
import MapKit

struct ClassLocation: Identifiable {
    var id: UUID = UUID()
    var title: String
    var color: String
    var imageURL: String
    var description: String
    var location: String
    var latitude: Double
    var longitude: Double
    
    var cooridnator: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension ClassLocation {
    static let examples: [ClassLocation] = [
        ClassLocation(
            title: "자취로운 수리생활",
            color: "72BF78",
            imageURL: "https://mediahub.seoul.go.kr/wp-content/uploads/mediahub/2024/06/AKRUQeHXmSstKeoOtJAWIYtFQpLgKPrB.png",
            description: "여가문화.체험.교육 프로그램",
            location: "종로구",
            latitude: 37.556296,
            longitude: 126.964702
        ),
        ClassLocation(
            title: "러닝 크루",
            color: "7ED4AD",
            imageURL: "https://mediahub.seoul.go.kr/wp-content/uploads/mediahub/2024/06/braduzFqKiuAlshrdzQcooZWqaeeCxiE.png",
            description: "1인 가구가 함께 어울려 프로그램을 만들어가는 동아리 활동",
            location: "종로구",
            latitude: 37.578314,
            longitude: 126.972726
        ),
        ClassLocation(
            title: "상담 프로그램",
            color: "638889",
            imageURL: "https://mediahub.seoul.go.kr/wp-content/uploads/mediahub/2024/06/EVMkKsuhEUNXbfMwWYnYxglprKkfyYZH.png",
            description: "마음이 지친1인 가구의 심리 정서 지원",
            location: "종로구",
            latitude: 37.572442,
            longitude: 126.986727
        ),
        ClassLocation(
            title: "동일이의 득심득심",
            color: "BC9F8B",
            imageURL: "https://mediahub.seoul.go.kr/wp-content/uploads/mediahub/2024/06/wTGyNiyoOYxAqziKNjitgwkbpXQJhiBH.png",
            description: "여가문화.체험.교육 프로그램",
            location: "종로구",
            latitude: 37.566473,
            longitude: 126.974722
        )
    ]
}
