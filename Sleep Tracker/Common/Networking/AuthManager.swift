//
//  AuthManager.swift
//  Sleep Tracker
//
//  Created by Dima Y on 21.02.2024.
//

import Foundation
import Alamofire
import KeychainAccess

enum AuthError: Error {
    case login
}

class AuthManager {
    public static let shared = AuthManager()
    private let keychainManager = Keychain(service: ApiConstants.bundleName)

    func login(email: String, password: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
        AF
            .request(SleepTrackerRouter.login(email, password))
            .validate()
            .responseDecodable(of: Login.self) { [weak self] data in
                guard let self else { return }

                switch data.result {
                case .success(let response):
                    do {
                       try keychainManager.set(response.token, key: ApiConstants.accessToken)
                        completion(.success(true))
                    } catch {
                        return
                    }

                case .failure:
                    completion(.failure(AuthError.login))
                }
            }
    }
}
