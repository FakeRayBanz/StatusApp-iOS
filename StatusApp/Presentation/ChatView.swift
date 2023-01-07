//
//  ChatView.swift
//  StatusApp
//
//  Created by Matthew Parker on 18/11/2022.
//

import SwiftUI

struct ChatView: View {
    var friend: User
    var drag: some Gesture {
        DragGesture()
            .onChanged { _ in messageTextFieldIsFocused = false }
    }

    @State var messageString = ""
    @FocusState var messageTextFieldIsFocused: Bool
    var body: some View {
        VStack {
            // Spacer()
            ScrollView {
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(0 ..< 20) {
                        Text("This is a test message \($0)")
                            .padding()
                            .background(Color(.systemBlue))
                            .cornerRadius(15)
                            .padding(2)
                    }
                    HStack {
                        Text("Test message")
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(15)
                            .padding(2)
                        Spacer()
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
                    // Send message
                }
                .buttonStyle(.borderedProminent)
                .padding(.trailing, 10)
            }
            .padding(.bottom)
        }
        .contentShape(Rectangle())
        .gesture(drag)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(friend: User())
    }
}
