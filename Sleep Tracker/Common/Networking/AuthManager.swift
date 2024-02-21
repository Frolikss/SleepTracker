//
//  AuthManager.swift
//  Sleep Tracker
//
//  Created by Dima Y on 21.02.2024.
//

import Foundation
import Alamofire

class AuthManager {
    public static let shared = AuthManager()

    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default

        configuration.waitsForConnectivity = true

        let interceptor = ApiRequestInterceptor()

        return Session(configuration: configuration, interceptor: interceptor)
    }()

    func login(email: String, password: String) {
        AF
            .request(SleepTrackerRouter.login(email, password))
            .validate()
            .response { data in
                print(data)
            }
//            .validate()
//            .publishResponse(using: Any.self)
//            .value()
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
}
