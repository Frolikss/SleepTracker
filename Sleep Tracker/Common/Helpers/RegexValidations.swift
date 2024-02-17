//
//  FieldValidations.swift
//  Sleep Tracker
//
//  Created by Dima Y on 17.02.2024.
//

import Foundation

enum RegexValidations: String {
    case email = #"[^\.\s][\w\-\.{2,}]+@([\w-]+\.)+[\w-]{2,}"#
}
