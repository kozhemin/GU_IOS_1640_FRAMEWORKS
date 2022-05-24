//
//  UserDefaults.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 24.05.2022.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let IsLogin = "IsLogin"
    }

    static var isLogin: Bool? {
        get { UserDefaults.standard.bool(forKey: Keys.IsLogin) }
        set { UserDefaults.standard.set(newValue!, forKey: Keys.IsLogin) }
    }
}
