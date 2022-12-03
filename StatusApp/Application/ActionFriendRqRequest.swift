//
//  ActionFriendRqRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import Foundation

func ActionFriendRequest(AccountId: String, FriendId: String, Accepted: Bool) async -> Bool {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    guard var urlComponents = URLComponents(string: "\(connectionString)/actionfriendrequest")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = [URLQueryItem(name: "userName", value: AccountId),
                                URLQueryItem(name: "friendUserName", value: FriendId),
                                URLQueryItem(name: "accepted", value: String(Accepted))]

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
