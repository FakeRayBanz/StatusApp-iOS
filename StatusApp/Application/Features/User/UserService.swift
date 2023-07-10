//
//  MessagesRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

class UserService {
    let _userClient: IUserClient;

    init() {
        _userClient = UserClient();
    }

    func CreateUser(userName: String, password: String, email: String, firstName: String, lastName: String) async -> Bool {
        let success = await _userClient.CreateUser(userName: userName, password: password, email: email, firstName: firstName, lastName: lastName);
        return success;
    }

    func UpdateUser(user: User) async -> Bool {
        let success = await _userClient.UpdateUser(user: user);
        return success;
    }

    func GetUser() async -> User {
        let user = await _userClient.GetUser();
        return user;
    }
}
