//
//  CheckDuplicateService.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation

struct CheckDuplicateService {
    /// 이메일 중복체크하는 함수
    /// - Parameters:
    ///   - request: 이메일
    ///   - completion: 통신 후 핸들러 (뷰컨트롤러에 있음)
    static func getEmailDuplicateCheck(
        request: CheckDuplicateRequestDTO,
        completion: @escaping (_ succeed: Bool?, _ failed: NetworkError?) -> Void) {
            NetworkService.shared.request(CheckDuplicateAPI.getDuplicateCheck(request)) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("=== getEmailDuplicateCheck error ===")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
