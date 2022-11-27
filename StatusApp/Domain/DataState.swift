//
//  DataState.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import Foundation
import SwiftUI

var dataState = DataState()

public class DataState: ObservableObject {
    @Published var currentUser: User = User();
    @Published var currentAccount: Account = Account();
    @Published var currentAccountId: Int = UserDefaults.standard.integer(forKey: "AccountId");
    @Published var friendsList: [User] = [];
    @Published var friendships: [Friendship] = [];
}
