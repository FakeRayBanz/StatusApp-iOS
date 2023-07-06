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

    @EnvironmentObject var dataState: DataState
    @State var messageString = ""
    @State private var scrollTarget: Int?
    @FocusState var messageTextFieldIsFocused: Bool

    let _messagesService = MessagingService();

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
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
                                    .contextMenu {
                                        Button("Edit") {}
                                        Button("Delete") {}
                                    }
                                if message.authorUserName != dataState.currentUserName {
                                    Spacer()
                                }
                            }
                            .id(message.messageId)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                // TODO: Fix view not expanding with keyboard dismiss gesture
                .scrollDismissesKeyboard(.interactively)
                .padding(5)
                .navigationTitle("\(friend.firstName) \(friend.lastName)")
                .onChange(of: scrollTarget) { target in
                    withAnimation {
                        proxy.scrollTo(target, anchor: .center)
                    }
                }
                .onChange(of: messageTextFieldIsFocused) { value in
                    if value == true {
                        withAnimation {
                            proxy.scrollTo(scrollTarget, anchor: .center)
                        }
                    }
                }
            }
            HStack {
                TextField("send a message", text: $messageString)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading)
                    .focused($messageTextFieldIsFocused)

                Button("Send") {
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
                                    scrollTarget = result!.messageId
                                    return
                                }
                                dataState.messages[groupId] = [result!]
                                scrollTarget = result!.messageId
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(.trailing, 10)
            }
            .padding(.bottom)
        }
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                TextField("send a message", text: $messageString)
//                    .textFieldStyle(.roundedBorder)
//                    .padding(.leading)
//                    .focused($messageTextFieldIsFocused)
//            }
//        }
        .task {
            // Add some data for previews
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                dataState.currentUserName = "BigMaurice"
                dataState.messages[groupId] = [Message(messageId: 26, groupId: UUID(), authorUserName: "BigMaurice", data: "Test", created: "2023-01-21T12:45:54.994558Z", lastUpdated: "0001-01-01T00:00:00"), Message(messageId: 27, groupId: UUID(), authorUserName: "Katie11", data: "Test2dhjkflajkla;fjioal;jfieaofjdajdskfljsdkfljkflsdjafkldaj;fkldaj;fieoajfdksla;fjdaklf;djak", created: "2023-01-21T12:45:54.994558Z", lastUpdated: "0001-01-01T00:00:00")]
            }
            // load all messages for this chat from the server
            let messages = await _messagesService.GetMessages(GroupId: groupId)
            if messages.count > 0 {
                dataState.messages[groupId] = messages
                scrollTarget = messages.last?.messageId
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
