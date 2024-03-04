//
//  Predicates.swift
//  Sleep Tracker
//
//  Created by Dima Y on 04.03.2024.
//

import Foundation

struct Validations {

    public static let shared = Validations()

    func validateEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", RegexValidations.email.rawValue)

        return emailPredicate.evaluate(with: email)
    }

    func validatePassword(_ password: String) -> Bool {
        let minLength = 8
        return password.count >= minLength
    }
}
