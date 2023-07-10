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
        let url = URL(string: "\(apiBaseUrl)/statushub")!
        connection = HubConnectionBuilder(url: url).withHubConnectionDelegate(delegate: signalRConnectionDelegate!).withLogging(minLogLevel: .error).build()
        connection.on(method: "ReceiveBroadcast", callback: { (user: String, message: String) in
            self.handleBroadcast(message, from: user)
        })
        connection.on(method: "ReceiveUpdatedUser", callback: { (friend: User) in
            if let targetIndex: Int = dataState.friendsList.firstIndex(where: { $0.userName == friend.userName }) {
                dataState.friendsList[targetIndex] = friend
            } else {
                dataState.friendsList.append(friend)
            }
        })
        connection.on(method: "ReceiveUpdatedFriendship", callback: { (friendship: Friendship) in
            if let targetIndex: Int = dataState.friendships.firstIndex(where: { $0.friendUserName == friendship.friendUserName }) {
                dataState.friendships[targetIndex] = friendship
            } else {
                dataState.friendships.append(friendship)
            }
        })
        connection.on(method: "DeleteFriend", callback: { (userName: String) in
            dataState.friendsList = dataState.friendsList.filter { $0.userName != userName }
        })
        connection.on(method: "ReceiveMessage", callback: { (message: Message) in
            print(message)
            let groupId = message.groupId
            if dataState.messages[groupId] != nil {
                dataState.messages[groupId]?.append(message)
                return
            }
            dataState.messages[groupId] = [message]
        })
    }

    private func handleBroadcast(_ message: String, from user: String) {
        print(user + ": " + message)
    }
}
