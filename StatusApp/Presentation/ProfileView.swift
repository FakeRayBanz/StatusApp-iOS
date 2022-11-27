//
//  ProfileView.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataState: DataState
    @State var accountIdInput: Int = 0
    var body: some View {
        VStack {
            Text("My Account")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 35)
            Text("Enter Account ID")
            TextField("Enter Account ID", value: $accountIdInput, format: .number)
                .frame(minWidth: 100, idealWidth: 200, maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.darkGray))
                .font(.system(size: 20))
                .padding(10)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color(.darkGray), lineWidth: 2)
                )
                .padding(.top, 5)
                .padding(.bottom, 50)
                .onSubmit {
                    Task {
                        await dataState.currentUser = GetUser(AccountId: accountIdInput)
                        await dataState.currentAccount = GetAccount(AccountId: accountIdInput)
                        await dataState.friendsList = GetFriendsList(AccountId: accountIdInput)
                        dataState.currentAccountId = dataState.currentUser.accountId
                        UserDefaults.standard.set(dataState.currentAccountId, forKey: "AccountId")
                    }
                }
            Group {
                LabeledContent("Account ID") {
                    Text(String(dataState.currentUser.accountId))
                }.padding(.horizontal, 60)
                LabeledContent("firstName") {
                    Text(dataState.currentUser.firstName)
                }.padding(.horizontal, 60)
                LabeledContent("lastName") {
                    Text(dataState.currentUser.lastName)
                }.padding(.horizontal, 60)
                LabeledContent("email") {
                    Text(dataState.currentAccount.email)
                }.padding(.horizontal, 60)
                LabeledContent("password") {
                    Text(dataState.currentAccount.password)
                }.padding(.horizontal, 60)
            }
            Group {
                LabeledContent("userName") {
                    Text(dataState.currentUser.userName)
                }.padding(.horizontal, 60)
                LabeledContent("phoneNumber") {
                    Text(dataState.currentAccount.phoneNumber)
                }.padding(.horizontal, 60)
                LabeledContent("status") {
                    Text(dataState.currentUser.status)
                }.padding(.horizontal, 60)
                LabeledContent("online") {
                    Text(String(dataState.currentUser.online))
                }.padding(.horizontal, 60)
            }

            Spacer()
                .task {
                    accountIdInput = dataState.currentAccountId
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(DataState())
    }
}
