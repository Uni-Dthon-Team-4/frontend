//
//  UserDefaultsManager.swift
//  Frontend
//
//  Created by Suyeon Hwang on 11/3/24.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    enum UserDefaultsKeys: String, CaseIterable {
        case id /// 해당 사용자의 id
        case email /// 해당 사용자의 이메일
        case uuid /// 해당 사용자의 핸들(@으로 시작하는)
        case age /// 나이
        case keyword1 /// 관심사1
        case keyword2 /// 관심사2
        case keyword3 /// 관심사3
    }
    
    func setData<T>(value: T, key: UserDefaultsKeys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getData<T>(type: T.Type, forKey: UserDefaultsKeys) -> T {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value ?? "unknown" as! T
    }
    
    func removeData(key: UserDefaultsKeys) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key.rawValue)
    }
}
