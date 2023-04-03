//
//  CreateUserDto.swift
//  StatusApp
//
//  Created by Matthew Parker on 3/4/2023.
//

import Foundation

class CreateUserDto : Encodable {
    var userName: String = ""
    var password: String = ""
    var email: String = ""
    var firstName: String = ""
    var lastName: String = ""
}
