//
//  SignalRService.swift
//  StatusApp
//
//  Created by Matthew Parker on 23/11/2022.
//

import Foundation
import SignalRClient

class SignalRConnectionDelegate: HubConnectionDelegate {
    func connectionDidOpen(hubConnection: SignalRClient.HubConnection) {
        dataState.signalRState = .didOpen
    }

    func connectionDidFailToOpen(error: Error) {
        dataState.signalRState = .didFailToOpen
    }

    func connectionDidClose(error: Error?) {
        dataState.signalRState = .didClose
    }
}

public class SignalRService {
    var signalRConnectionDelegate: HubConnectionDelegate? = SignalRConnectionDelegate()
    var connection: HubConnection
    public init() {
        let url = URL(string: "\(connectionString)/statushub")!
        connection = HubConnectionBuilder(url: url).withHubConnectionDelegate(delegate: signalRConnectionDelegate!).withAutoReconnect().withLogging(minLogLevel: .error).build()
        connection.on(method: "ReceiveMessage", callback: { (user: String, message: String) in
            self.handleMessage(message, from: user)
        })
        connection.on(method: "ReceiveUpdatedUser", callback: { (friend: User) in
            if let targetIndex: Int = dataState.friendsList.firstIndex(where: { $0.userName == friend.userName }) {
                dataState.friendsList[targetIndex] = friend
            } else {
                dataState.friendsList.append(friend)
            }
        })
        connection.on(method: "DeleteFriend", callback: { (userName: String) in
            dataState.friendsList = dataState.friendsList.filter { $0.userName != userName }
        })
    }

    private func handleMessage(_ message: String, from user: String) {
        print(user + ": " + message)
    }
}
