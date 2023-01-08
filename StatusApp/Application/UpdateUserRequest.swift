//
//  UpdateUserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 22/11/2022.
//

import Foundation

func UpdateUser(firstName: String? = nil, lastName: String? = nil, email: String? = nil, status: String? = nil, online: Bool? = nil) async -> Bool {
    guard var urlComponents = URLComponents(string: "\(connectionString)/updateUser")
    else {
        print("Invalid URL")
        return false
    }
    var queryItems: [URLQueryItem] = []
    if let firstName = firstName {
        queryItems.append(URLQueryItem(name: "firstName", value: String(firstName)))
    }
    if let lastName = lastName {
        queryItems.append(URLQueryItem(name: "lastName", value: String(lastName)))
    }
    if let email = email {
        queryItems.append(URLQueryItem(name: "email", value: String(email)))
    }
    if let status = status {
        queryItems.append(URLQueryItem(name: "status", value: String(status)))
    }
    if let online = online {
        queryItems.append(URLQueryItem(name: "online", value: String(online)))
    }
    urlComponents.queryItems = queryItems

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return false
    }
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"

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
