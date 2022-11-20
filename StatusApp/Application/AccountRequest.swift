//
//  AccountRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import Foundation

func GetAccount(AccountId: Int) async -> Account {
    let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
    let config: NSDictionary = NSDictionary(contentsOfFile: path)!
    let connectionString = config.object(forKey: "connectionString") as! String
    var account = Account()
    guard var urlComponents = URLComponents(string: "\(connectionString)/getaccount")
    else {
        print("Invalid URL")
        return Account()
    }
    urlComponents.queryItems = [URLQueryItem(name: "AccountId", value: String(AccountId))]

    guard let url = urlComponents.url
    else {
        print("Invalid URL")
        return Account()
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedResponse = try? JSONDecoder().decode(Account.self, from: data) {
            account = decodedResponse
        }
    } catch {
        print("Invalid Data")
    }
    return account
}
