//
//  RegisterViewModel.swift
//  Sleep Tracker
//
//  Created by Dima Y on 29.02.2024.
//

import Foundation
import Combine

class RegisterViewModel {
    private let email = CurrentValueSubject<String, Never>("")
    private let password = CurrentValueSubject<String, Never>("")
    private let date = CurrentValueSubject<Date?, Never>(nil)

    private var isCorrectEmail: AnyPublisher<Bool, Never> {
        email
            .map { Validations.shared.validateEmail($0) }
            .eraseToAnyPublisher()
    }

    private var isCorrectPassword: AnyPublisher<Bool, Never> {
        password
            .map { Validations.shared.validatePassword($0) }
            .eraseToAnyPublisher()
    }

    private var isCorrectDate: AnyPublisher<Bool, Never> {
        date
            .map { $0 != nil }
            .eraseToAnyPublisher()
    }

    private var cancellables = Set<AnyCancellable>()

    public func setEmail(_ email: String) {
        self.email.value = email
    }

    public func setPassword(_ password: String) {
        self.password.value = password
    }

    public func setDate(_ date: Date) {
        self.date.value = date
    }

    public func getIsCorrectEmail() -> AnyPublisher<Bool, Never> {
        return isCorrectEmail
    }

    public func getIsCorrectPassword() -> AnyPublisher<Bool, Never> {
        return isCorrectPassword
    }

    public func getIsCorrectDate() -> AnyPublisher<Bool, Never> {
        return isCorrectDate
    }
}
