//
//  ProfileView.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataState: DataState
    @Binding var showProfileView: Bool
    @Binding var showOnboardingView: Bool
    @State var userNameInput: String = ""
    var body: some View {
        VStack {
            Text("My Account")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 35)
            Text("Enter Account ID")
            TextField("Enter User Name", text: $userNameInput)
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
                        dataState.currentUser = await GetUser(userName: userNameInput)
                        dataState.currentUserName = dataState.currentUser.userName
                        UserDefaults.standard.set(dataState.currentUserName, forKey: "userName")
                        // await dataState.currentAccount = GetAccount(userName: userNameInput)
                        dataState.friendsList = await GetFriendsList(userName: userNameInput)
                    }
                }
            Group {
                LabeledContent("UserName") {
                    Text(String(dataState.currentUser.userName))
                }.padding(.horizontal, 60)
                LabeledContent("firstName") {
                    Text(dataState.currentUser.firstName)
                }.padding(.horizontal, 60)
                LabeledContent("lastName") {
                    Text(dataState.currentUser.lastName)
                }.padding(.horizontal, 60)
                LabeledContent("status") {
                    Text(dataState.currentUser.status)
                }.padding(.horizontal, 60)
                LabeledContent("online") {
                    Text(String(dataState.currentUser.online))
                }.padding(.horizontal, 60)
            }

            Spacer()
            Button("Sign Out") {
                Task {
                    await SignOut()
                }
                dataState.currentUserName = ""
                UserDefaults.standard.set("", forKey: "userName")
                showProfileView = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showOnboardingView = true
                }
                dataState.currentUser = User()
                dataState.friendsList.removeAll()
                dataState.friendships.removeAll()
            }
            .buttonStyle(.borderedProminent)
        }
        .task {
            userNameInput = dataState.currentUserName
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfileView: .constant(true), showOnboardingView: .constant(false))
            .environmentObject(DataState())
    }
}
