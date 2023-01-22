//
//  Message.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

struct Message: Codable {
    var messageId: Int;
    var groupId: UUID;
    var authorUserName: String;
    var data: String;
    var created: String;
    var lastUpdated: String;
}
