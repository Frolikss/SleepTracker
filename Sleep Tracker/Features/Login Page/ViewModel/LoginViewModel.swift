//
//  LoginViewModel.swift
//  Sleep Tracker
//
//  Created by Dima Y on 17.02.2024.
//

import Foundation
import Combine

enum LoginViewState {
    case loading
    case uknown
    case failure
    case success
}

class LoginViewModel {
    private let email = CurrentValueSubject<String, Never>("")
    private let password = CurrentValueSubject<String, Never>("")
    private let state = CurrentValueSubject<LoginViewState, Never>(.uknown)

    private var cancellables = Set<AnyCancellable>()

    private var isCorrectEmail: AnyPublisher<Bool, Never> {
        email
            .map { email in
                let emailPredicate = NSPredicate(format: "SELF MATCHES %@", RegexValidations.email.rawValue)

                return emailPredicate.evaluate(with: email)
            }
            .eraseToAnyPublisher()
    }

    private var isCorrectPassword: AnyPublisher<Bool, Never> {
        password
            .map { password in
                let minLength = 8
                return password.count >= minLength
            }
            .eraseToAnyPublisher()
    }

    private var isLoginEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isCorrectEmail, isCorrectPassword)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }

    public func setEmail(_ email: String) {
        self.email.value = email
    }

    public func setPassword(_ password: String) {
        self.password.value = password
    }

    public func getIsCorrectEmail() -> AnyPublisher<Bool, Never> {
        return isCorrectEmail
    }

    public func getIsCorrectPassword() -> AnyPublisher<Bool, Never> {
        return isCorrectPassword
    }

    public func getIsLoginEnabled() -> AnyPublisher<Bool, Never> {
        return isLoginEnabled
    }

    public func submitLogin() {
        state.value = .loading

        AuthManager.shared.login(email: email.value, password: password.value)
    }
}
