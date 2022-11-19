//
//  FriendsListRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import Foundation

func GetFriendsList(AccountId: Int) async -> [User] {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String

    var friendsList: [User] = []
    guard var urlComponents = URLComponents(string: "\(connectionString)/getfriends")
    else {
        print("Invalid URL")
        return []
    }
    urlComponents.queryItems = [URLQueryItem(name: "AccountId", value: String(AccountId))]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return []
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
