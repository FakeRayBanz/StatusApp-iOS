//
//  ContentView.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import SignalRClient
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataState: DataState
    let signalR: SignalRService = SignalRService()
    @State var showProfileView: Bool = false
    @State var showStatusView: Bool = false
    @State var showAddFriendView: Bool = false
    @State var showOnboardingView: Bool = false
    var statusRed = Color(UIColor(red: 0.96, green: 0, blue: 0, alpha: 1))
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { showProfileView.toggle() }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(.init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)))
                            .frame(width: 35, height: 35)
                            .padding(.leading, 25)
                    }
                    Spacer()
                    Text("Status")
                        .font(.title)
                    Spacer()
                    Button(action: { showStatusView.toggle() }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(dataState.currentUser.online ? .green : statusRed)
                            .shadow(radius: 5)
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
                Button("Send Message") {
                    signalR.connection.invoke(method: "SendMessage", "User1", "TestMessage") { error in
                        if let error = error {
                            print("error: \(error)")
                        } else {
                            print("Send success")
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
                Button("Add Friends") {
                    showAddFriendView.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
                FriendsStatusView()
                Spacer()
            }
            .sheet(isPresented: $showProfileView) {
                ProfileView(showProfileView: $showProfileView, showOnboardingView:  $showOnboardingView)
            }
            .sheet(isPresented: $showStatusView) {
                StatusView()
            }
            .sheet(isPresented: $showAddFriendView) {
                AddFriendView()
            }
            .fullScreenCover(isPresented: $showOnboardingView) {
                SignInUpView(showOnboardingView: $showOnboardingView)
            }
            .task {
                // if dataState.currentAccountId == -1, present fullscreen cover to "sign in"
                print("CurrentUserName: " + dataState.currentUserName)
                if dataState.currentUserName != "" {
                    dataState.currentUser = await GetUser(userName: dataState.currentUserName)
                    // dataState.currentAccount = await GetAccount(userName: dataState.currentUserName)
                    dataState.friendsList = await GetFriendsList(userName: dataState.currentUserName)

                } else {
                    showOnboardingView = true
                }
                signalR.connection.invoke(method: "SendMessage", "User1", "TestMessage") { error in
                    if let error = error {
                        print("error: \(error)")
                    } else {
                        print("Send success")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataState())
    }
}
