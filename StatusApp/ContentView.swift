//
//  ContentView.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataState: DataState
    @State var showUserView: Bool = false
    @State var showStatusView: Bool = false
    @State var showAddFriendView: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { showUserView.toggle() }) {
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
                            .foregroundColor(.green)
                            .shadow(radius: 5)
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
                Button("Add Friends") {
                    showAddFriendView.toggle()
                }
                .buttonStyle(.borderedProminent)
                .padding(5)
                FriendsStatusView()
                Spacer()
            }
            .sheet(isPresented: $showUserView) {
                ProfileView()
            }
            .sheet(isPresented: $showStatusView) {
                StatusView()
            }
            .sheet(isPresented: $showAddFriendView) {
                AddFriendView()
            }
            .task {
                //if dataState.currentAccountId == -1, present fullscreen cover to "sign in"
                await dataState.currentUser = GetUser(AccountId: dataState.currentAccountId)
                await dataState.currentAccount = GetAccount(AccountId: dataState.currentAccountId)
                await dataState.friendsList = GetFriendsList(AccountId: dataState.currentAccountId)
                dataState.currentAccountId = dataState.currentUser.accountId
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
