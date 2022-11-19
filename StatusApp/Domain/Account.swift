//
//  Account.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import Foundation

struct Account: Codable {
    var accountId: Int = -1
    var email: String = ""
    var password: String = ""
    var userName: String = ""
    var phoneNumber: String = ""
}
