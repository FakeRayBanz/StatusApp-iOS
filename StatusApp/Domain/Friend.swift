//
//  Friend.swift
//  StatusApp
//
//  Created by Matthew Parker on 18/11/2022.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id = UUID()
    var accountId: Int = -1
    var firstName: String = ""
    var lastName: String = ""
    var userName: String = ""
    var status: String = ""
    var online: Bool = false
}
