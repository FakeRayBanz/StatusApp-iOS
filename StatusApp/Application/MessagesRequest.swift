//
//  MessagesRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

func GetMessages(GroupId: UUID) async -> [Message] {
    var messages: [Message] = []
    guard var urlComponents = URLComponents(string: "\(connectionString)/getMessages")
    else {
        print("Invalid URL")
        return []
    }
    urlComponents.queryItems = [URLQueryItem(name: "groupId", value: GroupId.uuidString)]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return []
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([Message].self, from: data) {
            messages = decodedResponse
        }
    } catch {
        print("Invalid Data")
    }
    return messages
}
