//
//  SignInRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 3/12/2022.
//

import Foundation

func SignInRequest(userName: String, password: String) async -> Bool {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    // var friendship: Friendship = Friendship()
    guard var urlComponents = URLComponents(string: "\(connectionString)/signin")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = [
        URLQueryItem(name: "userName", value: userName),
        URLQueryItem(name: "password", value: password)
    ]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return false
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    do {
        let (_, info) = try await URLSession.shared.data(for: request)
        if let httpResponse = info as? HTTPURLResponse {
            print(httpResponse.statusCode)
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
