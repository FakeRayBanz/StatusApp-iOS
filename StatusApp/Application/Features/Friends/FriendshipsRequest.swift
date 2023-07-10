//
//  FriendshipsRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import Foundation

func GetFriendships() async -> [Friendship] {
    var friendships: [Friendship] = []
    guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/getfriendships")
    else {
        print("Invalid URL")
        return friendships
    }
    urlComponents.queryItems = []

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return friendships
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode([Friendship].self, from: data) {
            friendships = decodedResponse
        }
    } catch {
        print("Invalid Data")
    }
    return friendships
}
