//
//  UserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

// Needing parameters extracted to variables
func GetUser() async -> User {
    var user = User()
    guard let url = URL(string: "") else {
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
