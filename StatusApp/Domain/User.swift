//
//  User.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

struct User: Codable {
    var accountId: Int?;
    var firstName: String?;
    var lastName: String?;
    var email: String?;
    var password: String?;
    var userName: String?;
    var phoneNumber: String?;
    var status: String?;
    var online: Bool?;
}
