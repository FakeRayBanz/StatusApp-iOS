//
//  CreateUserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 30/11/2022.
//

import Foundation

// TODO: pass in a CreateUserDto
func CreateUser(userName: String, password: String, email: String, firstName: String, lastName: String) async -> Bool {
    guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/createuser")
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
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let encoder = JSONEncoder()
    do {
        
        let dto = CreateUserDto()
        dto.userName = userName
        dto.firstName = firstName
        dto.lastName = lastName
        dto.email = email
        dto.password = password
        
        let jsonData = try encoder.encode(dto)
        request.httpBody = jsonData
        let (_, info) = try await URLSession.shared.data(for: request)
        if let httpResponse = info as? HTTPURLResponse {
            if httpResponse.statusCode == 200 {
                // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                // friendship = decodedResponse
                print("Created successfully")
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
