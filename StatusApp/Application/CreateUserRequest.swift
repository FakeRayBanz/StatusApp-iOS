//
//  CreateUserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 30/11/2022.
//

import Foundation

func CreateUser(UserName: String, Password: String, Email: String, FirstName: String, LastName: String) async -> Bool {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    guard var urlComponents = URLComponents(string: "\(connectionString)/createuser")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = [
        URLQueryItem(name: "userName", value: String(UserName)),
        URLQueryItem(name: "password", value: String(Password)),
        URLQueryItem(name: "email", value: String(Email)),
        URLQueryItem(name: "firstName", value: String(FirstName)),
        URLQueryItem(name: "lastName", value: String(LastName))
    ]

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
