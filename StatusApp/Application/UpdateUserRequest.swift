//
//  UpdateUserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 22/11/2022.
//

import Foundation

func UpdateUser(UserName: String, FirstName: String? = nil, LastName: String? = nil, Email: String? = nil, Status: String? = nil, Online: Bool? = nil) async -> Bool {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    guard var urlComponents = URLComponents(string: "\(connectionString)/updateUser")
    else {
        print("Invalid URL")
        return false
    }
    var queryItems: [URLQueryItem] = [URLQueryItem(name: "userName", value: String(UserName))]
    if let firstName = FirstName {
        queryItems.append(URLQueryItem(name: "firstName", value: String(firstName)))
    }
    if let lastName = LastName {
        queryItems.append(URLQueryItem(name: "lastName", value: String(lastName)))
    }
    if let email = Email {
        queryItems.append(URLQueryItem(name: "email", value: String(email)))
    }
    if let status = Status {
        queryItems.append(URLQueryItem(name: "status", value: String(status)))
    }
    if let online = Online {
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
