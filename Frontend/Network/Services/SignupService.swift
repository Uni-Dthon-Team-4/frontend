//
//  SignupService.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation

struct SignupService {
    /// 회원가입하는 함수
    /// - Parameters:
    ///   - request: 회원가입에 필요한 사용자 정보
    ///   - completion: 통신 후 핸들러 (뷰컨트롤러에 있음)
    static func postSignup(
        request: SignupRequestDTO,
        completion: @escaping (_ succeed: SignupResponseDTO?, _ failed: NetworkError?) -> Void) {
            NetworkService.shared.request(SignupAPI.postSignup(request)) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("=== postSignup error ===")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
