//
//  UpdateUserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 22/11/2022.
//

import Foundation

func UpdateUser(user: User) async -> Bool {
    guard var urlComponents = URLComponents(string: "\(connectionString)/updateuser")
    else {
        print("Invalid URL")
        return false
    }
    let queryItems: [URLQueryItem] = []
    urlComponents.queryItems = queryItems

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return false
    }
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let encoder = JSONEncoder()

    do {
        let jsonData = try encoder.encode(user)
        request.httpBody = jsonData
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
