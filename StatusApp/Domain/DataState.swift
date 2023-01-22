//
//  DataState.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import Foundation
import SwiftUI

private let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
private let config: NSDictionary = NSDictionary(contentsOfFile: path)!
let connectionString = config.object(forKey: "connectionString") as! String

var dataState = DataState()
let signalR: SignalRService = SignalRService()

public enum SignalRState {
    case didOpen
    case didClose
    case didFailToOpen
    case initial
}

public class DataState: ObservableObject {
    @Published var currentUser: User = User();
    @Published var currentAccount: Account = Account();
    @Published var currentUserName: String = (UserDefaults.standard.string(forKey: "userName") ?? "");
    @Published var friendsList: [User] = [];
    @Published var friendships: [Friendship] = [];
    @Published var messages: [UUID: [Message]] = [:];
    @Published var signalRState: SignalRState = .initial;
}
