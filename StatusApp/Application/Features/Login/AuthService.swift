//
//  MessagesRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

class AuthService {
    let _authClient: IAuthClient;

    init() {
        _authClient = AuthClient();
    }

    func CheckAuth() async -> Bool {
        let result = await _authClient.CheckAuth();
        return result;
    }

    func SignOut() async -> Bool {
        let success = await _authClient.SignOut();
        return success;
    }

    func SignInRequest(userName: String, password: String) async -> Bool {
        let success = await _authClient.SignInRequest(userName: userName, password: password);
        return success;
    }
}
