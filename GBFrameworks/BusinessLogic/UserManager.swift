//
//  UserManager.swift
//  GBFrameworks
//
//  Created by Егор Кожемин on 23.05.2022.
//

import CryptoKit
import Foundation
import RealmSwift

protocol UserManagerProtocol {
    func create(login: String, password: String) -> Bool
    func login(login: String, password: String) -> Bool
}

class UserManager: UserManagerProtocol {
    func create(login: String, password: String) -> Bool {
        guard let passwordHash = strToHash(password) else { return false }

        if let user = findByLogin(login: login) {
            return updateUser(user: user, newPass: passwordHash)
        }

        let user = RealmUser(login: login, password: passwordHash)
        do {
            try RealmService.save(items: [user])
        } catch {
            assertionFailure("User not created")
            return false
        }

        return true
    }

    func login(login: String, password: String) -> Bool {
        guard let user = findByLogin(login: login),
              let passwordHash = strToHash(password)
        else { return false }

        return user.password == passwordHash
    }

    private func updateUser(user: RealmUser, newPass: String) -> Bool {
        do {
            let realm = try Realm()
            try? realm.safeWrite {
                user.password = newPass
            }
        } catch {
            assertionFailure("User not updated")
            return false
        }

        return true
    }

    private func findByLogin(login: String) -> RealmUser? {
        let users = try? RealmService.load(typeOf: RealmUser.self)
        let searchUser = users?.where {
            $0.login.contains(login)
        }

        return searchUser?.first
    }

    private func strToHash(_ str: String) -> String? {
        let inputData = Data(str.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
