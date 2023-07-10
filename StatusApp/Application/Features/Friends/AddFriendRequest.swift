//
//  AddFriendRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import Foundation

func SendFriendRequest(friendUserName: String) async -> Bool {
    guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/sendfriendrequest")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName)]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return false
    }
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"

    do {
        let (_, info) = try await URLSession.shared.data(for: request)
        if let httpResponse = info as? HTTPURLResponse {
            print(httpResponse.statusCode)
            if httpResponse.statusCode == 200 {
                // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                // friendship = decodedResponse
                return true

            } else {
                return false
            }
        }
    } catch {
        print("Invalid Data")
        return false
    }
    return false
}
