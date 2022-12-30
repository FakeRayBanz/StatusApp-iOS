//
//  AddFriendView.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import SwiftUI

struct AddFriendView: View {
    @EnvironmentObject var dataState: DataState
    @State var searchString: String = ""
    @State var errorString: String = ""
    var body: some View {
        VStack(spacing: 0) {
            Text("Add Friends")
                .font(.largeTitle)
                .padding(.top)

            TextField("Enter your friend's username", text: $searchString)
                .textFieldStyle(.roundedBorder)
                .padding()
                .onSubmit {
                    print("submitted")
                    Task {
                        let requestSucceeded = await SendFriendRequest(friendUserName: searchString)
                        if requestSucceeded == true {
                            errorString = "Request successfully sent"
                            // Task get request list
                            Task {
                                dataState.friendships = await GetFriendships()
                            }
                        } else {
                            errorString = "That username does not exist"
                        }
                    }
                }
            Text(errorString)
                .padding(.bottom)
            ForEach(dataState.friendships, id: \.friendUserName) { friend in
                HStack {
                    Text("\(friend.friendFirstName) \(friend.friendLastName)")
                    Text(friend.friendUserName)
                    Spacer()
                    if friend.areFriends == true, friend.accepted == true {
                        Button("Remove Friend") {
                            Task {
                                let success = await RemoveFriend(friendUserName: friend.friendUserName)
                                if success == true {
                                    Task {
                                        dataState.friendships = await GetFriendships()
                                        dataState.friendsList = await GetFriendsList()
                                    }
                                }
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                    if friend.areFriends == false, friend.accepted == true {
                        Button("Cancel Request") {
                            Task {
                                let success = await ActionFriendRequest(friendUserName: friend.friendUserName, accepted: false)
                                if success == true {
                                    Task {
                                        dataState.friendships = await GetFriendships()
                                    }
                                }
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                    if friend.areFriends == false, friend.accepted == false {
                        Button("Accept Request") {
                            Task {
                                let success = await ActionFriendRequest(friendUserName: friend.friendUserName, accepted: true)
                                if success == true {
                                    Task {
                                        dataState.friendships = await GetFriendships()
                                        dataState.friendsList = await GetFriendsList()
                                    }
                                }
                            }
                        }.buttonStyle(.borderedProminent)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }

            Spacer()
        }
        .task {
            dataState.friendships = await GetFriendships()
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
            .environmentObject(DataState())
    }
}
