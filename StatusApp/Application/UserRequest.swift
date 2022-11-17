//
//  UserRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Alamofire
import Foundation

func GetUser(AccountId: Int) -> User {
    var aUser = User()
    let url: String = ""
    AF.request(url, method: .get).responseDecodable(of: User.self) { response in
        switch response.result {
        case .success(let user):
            aUser = user;
            print(aUser);
        case .failure(let error):
            print(error);
        }
    }
    return aUser
}
