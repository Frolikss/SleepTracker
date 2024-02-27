//
//  UserManager.swift
//  Sleep Tracker
//
//  Created by Dima Y on 27.02.2024.
//

import Foundation
import Alamofire

class UserManager {
    public static let shared = UserManager()

    private let sesstionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.waitsForConnectivity = true

        let interceptor = ApiRequestInterceptor()

        return Session(configuration: configuration, interceptor: interceptor)
    }()

    func getSelf(completion: @escaping (User?) -> Void) {
        sesstionManager
            .request(SleepTrackerRouter.getSelf)
            .validate()
            .responseDecodable(of: User.self) { response in
                guard let user = response.value else {
                    return completion(nil)
                }
                completion(user)
            }
    }
}
