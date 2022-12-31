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
    var body: some View {
        VStack {
            Text("My Account")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 35)
            Text(dataState.currentUserName)
                .frame(minWidth: 100, idealWidth: 200, maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.darkGray))
                .font(.system(size: 26))
                .padding(10)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color(.darkGray), lineWidth: 2)
                )
                .padding(.top, 5)
                .padding(.bottom, 50)
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
                signalR.connection.stop()
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfileView: .constant(true), showOnboardingView: .constant(false))
            .environmentObject(DataState())
    }
}
