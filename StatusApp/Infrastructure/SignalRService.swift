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
        // print(dataState.signalRState)
        signalR.connection.invoke(method: "SendMessage", dataState.currentUserName, "SignalR Connected") { error in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Send success")
            }
        }
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
            if dataState.friendsList.count != 0 {
                for i in 0 ... (dataState.friendsList.count - 1) {
                    if dataState.friendsList[i].userName == friend.userName {
                        dataState.friendsList[i] = friend
                    }
                }
            }
        })
    }

    private func handleMessage(_ message: String, from user: String) {
        print(user + ": " + message)
    }
}
