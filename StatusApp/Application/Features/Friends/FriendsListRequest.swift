//
//  FriendsListRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import Foundation

func GetFriendsList() async -> [User] {
    var friendsList: [User] = []
    guard var urlComponents = URLComponents(string: "\(connectionString)/getfriends")
    else {
        print("Invalid URL")
        return friendsList
    }
    urlComponents.queryItems = []

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return friendsList
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
            friendsList = decodedResponse
        }
    } catch {
        print("Invalid Data")
    }
    return friendsList
}
