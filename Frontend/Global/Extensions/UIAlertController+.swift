//
//  UIAlertController+.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/2/24.
//

import UIKit

extension UIAlertController {
    
    /// 서버 통신 실패 했을 때
    static func networkErrorAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: "다시 시도해주세요.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        return alert
    }
}
