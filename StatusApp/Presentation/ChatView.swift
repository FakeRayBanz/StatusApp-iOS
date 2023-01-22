//
//  ChatView.swift
//  StatusApp
//
//  Created by Matthew Parker on 18/11/2022.
//

import SwiftUI

struct ChatView: View {
    var friend: User
    var groupId: UUID
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in messageTextFieldIsFocused = false }
    }

    @EnvironmentObject var dataState: DataState
    @State var messageString = ""
    @FocusState var messageTextFieldIsFocused: Bool
    var body: some View {
        VStack {
            // Spacer()
            ScrollView {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(dataState.messages[groupId] ?? [], id: \.messageId) { message in
                        HStack {
                            Text(message.data)
                                .padding()
                                .background(message.authorUserName != dataState.currentUserName ? Color(.systemGray5) : Color(.systemBlue))
                                .cornerRadius(15)
                                .padding(.trailing, message.authorUserName != dataState.currentUserName ? 50 : 0)
                                .padding(.leading, message.authorUserName != dataState.currentUserName ? 0 : 50)
                                .padding(2)
                            if message.authorUserName != dataState.currentUserName {
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(5)
            .navigationTitle("\(friend.firstName) \(friend.lastName)")
            Spacer()
            HStack {
                TextField("send a message", text: $messageString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading)
                    .focused($messageTextFieldIsFocused)

                Button("Send") {
                    messageTextFieldIsFocused = false
                    if messageString == "" { return }
                    Task {
                        signalR.connection.invoke(method: "SendMessage", groupId, messageString, resultType: Message.self) { result, error in
                            if let error = error {
                                print("error: \(error)")
                            } else {
                                // Task.result or something like that
                                // TODO: Need to check for success
                                let groupId = result!.groupId
                                if dataState.messages[groupId] != nil {
                                    dataState.messages[groupId]?.append(result!)
                                    return
                                }
                                dataState.messages[groupId] = [result!]
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.trailing, 10)
            }
            .padding(.bottom)
        }
        .contentShape(Rectangle())
        .gesture(drag)
        .task {
            // Add some data for previews
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                dataState.currentUserName = "BigMaurice"
                dataState.messages[groupId] = [Message(messageId: 26, groupId: UUID(), authorUserName: "BigMaurice", data: "Test", created: "2023-01-21T12:45:54.994558Z", lastUpdated: "0001-01-01T00:00:00"), Message(messageId: 27, groupId: UUID(), authorUserName: "Katie11", data: "Test2dhjkflajkla;fjioal;jfieaofjdajdskfljsdkfljkflsdjafkldaj;fkldaj;fieoajfdksla;fjdaklf;djak", created: "2023-01-21T12:45:54.994558Z", lastUpdated: "0001-01-01T00:00:00")]
            }
            // load all messages for this chat from the server
            let messages = await GetMessages(GroupId: groupId)
            if messages.count > 0 {
                dataState.messages[groupId] = messages
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(friend: User(), groupId: UUID())
            .environmentObject(dataState)
    }
}
