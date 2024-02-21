//
//  SleepTrackerRouter.swift
//  Sleep Tracker
//
//  Created by Dima Y on 21.02.2024.
//

import Foundation
import Alamofire

enum SleepTrackerRouter {
    case login(String, String)

    var baseUrl: String {
        switch self {
        case .login:
            return ApiConstants.baseUrl
        }
    }

    var path: String {
        switch self {
        case .login:
            return ApiPaths.login.rawValue
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var parameters: [String: String]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]
        }
    }
}

extension SleepTrackerRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL().appending(path: path, directoryHint: .inferFromPath)

        var request = URLRequest(url: url)
        request.method = method

        switch method {
        case .post:
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        default:
            break
        }

        return request
    }

}
