//
//  FriendshipsRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import Foundation

func GetFriendships(userName: String) async -> [Friendship] {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    var friendships: [Friendship] = []
    guard var urlComponents = URLComponents(string: "\(connectionString)/getfriendships")
    else {
        print("Invalid URL")
        return friendships
    }
    urlComponents.queryItems = [URLQueryItem(name: "userName", value: userName)]

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
