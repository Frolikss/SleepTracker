//
//  User.swift
//  Sleep Tracker
//
//  Created by Dima Y on 27.02.2024.
//

import Foundation

struct User: Decodable {
    let user: UserData
}

struct UserData: Decodable {
    let name: String
    let email: String
    let gender: String
    let birthday: String
    let phone: String
}
