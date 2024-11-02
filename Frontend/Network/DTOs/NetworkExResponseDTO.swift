//
//  NetworkExResponseDTO.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

/// 1. 서버로 보내는 요청 혹은 받는 응답의 DTO를 작성합니다.
struct HomeResponse: Codable {
    let isSuccess : Bool
    let code: String
    let message: String
    let result: HomeDataResult
}

struct HomeDataResult: Codable {
    let pageInfo : HomeDataPageInfo
    let postList : [HomeDataPostList]
}

struct HomeDataPageInfo: Codable {
    let lastPage: Bool
    let totalPages: Int
    let totalElements: Int
    let size: Int
}

struct HomeDataPostList: Codable {
    let postId: Int
    let postImage: String
}
