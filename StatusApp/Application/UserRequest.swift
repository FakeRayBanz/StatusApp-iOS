//
//  UserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

func GetUser() async -> User {
    var user = User()
    guard var urlComponents = URLComponents(string: "\(connectionString)/getUser")
    else {
        print("Invalid URL")
        return User()
    }
    urlComponents.queryItems = []

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
