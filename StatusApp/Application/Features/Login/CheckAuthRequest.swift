//
//  CheckAuthRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 30/12/2022.
//

import Foundation

func CheckAuth() async -> Bool {
    guard var urlComponents = URLComponents(string: "\(connectionString)/checkauth")
    else {
        print("Invalid URL")
        return false
    }
    urlComponents.queryItems = []

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
            // print(httpResponse.statusCode)
            if httpResponse.statusCode == 200 {
                return true
            } else if httpResponse.statusCode == 401 {
                // TODO: Prompt sign in
                return false
            } else {
                return true
            }
        }
    } catch {
        print("Invalid Data")
        return false
    }
    return false
}
