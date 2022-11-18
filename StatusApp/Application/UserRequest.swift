//
//  UserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

func GetUser(AccountId: Int) async -> User {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String

    var user = User()
    guard var urlComponents = URLComponents(string: "\(connectionString)/getuser")
    else {
        print("Invalid URL")
        return User()
    }
    urlComponents.queryItems = [URLQueryItem(name: "AccountId", value: String(AccountId))]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return User()
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
            user = decodedResponse
        }
    } catch {
        print("Invalid Data")
    }
    return user
}
