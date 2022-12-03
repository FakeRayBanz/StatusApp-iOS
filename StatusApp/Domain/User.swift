//
//  User.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

struct User: Codable {
    var userName: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var status: String = ""
    var online: Bool = false
}
