//
//  RemoveFriendRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import Foundation

func RemoveFriend(AccountId: Int, FriendId: Int) async -> Bool {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    // var friendship: Friendship = Friendship()
    guard var urlComponents = URLComponents(string: "\(connectionString)/removefriend")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = [URLQueryItem(name: "AccountId", value: String(AccountId)), URLQueryItem(name: "FriendId", value: String(FriendId))]
    
    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return false
    }
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    do {
        let (_, info) = try await URLSession.shared.data(for: request)
        if let httpResponse = info as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                //if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
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
