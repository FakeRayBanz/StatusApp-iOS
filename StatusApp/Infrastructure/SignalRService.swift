//
//  SignalRService.swift
//  StatusApp
//
//  Created by Matthew Parker on 23/11/2022.
//

import Foundation
import SignalRClient

public class SignalRService {
    var connection: HubConnection
    // var accountId = UserDefaults.standard.integer(forKey: "AccountId")
    var userName: String = "BigMaurice"
    public init() {
        let path: String = Bundle.main.path(forResource: "Config", ofType: "plist")!
        let config: NSDictionary = NSDictionary(contentsOfFile: path)!
        let connectionString = config.object(forKey: "connectionString") as! String
        let url = URL(string: "\(connectionString)/statushub?userName=\(userName)")!

        connection = HubConnectionBuilder(url: url).withLogging(minLogLevel: .error).build()
        connection.on(method: "ReceiveMessage", callback: { (user: String, message: String) in
            self.handleMessage(message, from: user)
        })
        connection.on(method: "ReceiveUpdatedUser", callback: { (friend: User) in
            if dataState.friendsList.count != 0 {
                for i in 0 ... (dataState.friendsList.count - 1) {
                    if dataState.friendsList[i].userName == friend.userName {
                        dataState.friendsList[i] = friend
                    }
                }
            }
        })
        //connection.start()
        // Add connectionStatusDelegate
    }

    private func handleMessage(_ message: String, from user: String) {
        print(user + ": " + message)
    }
}
