//
//  AppConfiguration.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 29.05.2022.
//  use config Debug.xcconfig

import Foundation

enum AppConfiguration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var GMS_KEY: String {
        return try! AppConfiguration.value(for: "GMS_API_KEY")
    }
}
