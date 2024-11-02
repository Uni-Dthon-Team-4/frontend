//
//  LoginService.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation

struct LoginService {
    /// 로그인하는 함수
    /// - Parameters:
    ///   - request: 회원가입에 필요한 사용자 정보
    ///   - completion: 통신 후 핸들러 (뷰컨트롤러에 있음)
    static func postLogin(
        request: LoginRequestDTO,
        completion: @escaping (_ succeed: SignupResponseDTO?, _ failed: NetworkError?) -> Void) {
            NetworkService.shared.request(LoginAPI.postLogin(request)) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("=== postLogin error ===")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
