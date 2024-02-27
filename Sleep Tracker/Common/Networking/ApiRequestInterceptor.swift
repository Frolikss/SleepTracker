//
//  RequestInterceptor.swift
//  Sleep Tracker
//
//  Created by Dima Y on 21.02.2024.
//

import Foundation
import Alamofire
import KeychainAccess

enum InterceptorError: Error {
    case noToken
    case unknown
}

class ApiRequestInterceptor: RequestInterceptor {
    private let keychainManager = Keychain(service: ApiConstants.bundleName)

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        do {
            guard let token = try keychainManager.get(ApiConstants.accessToken) else {
                throw InterceptorError.noToken
            }
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
        } catch let error as InterceptorError {
            completion(.failure(error))
        } catch {
            completion(.failure(InterceptorError.unknown))
        }
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse

        guard let statusCode = response?.statusCode, statusCode != 401 else {
            try? keychainManager.remove(ApiConstants.accessToken)
            return completion(.doNotRetry)
        }

        return completion(.doNotRetry)
    }
}
