//
//  SignUpPasswordView.swift
//  StatusApp
//
//  Created by Matthew Parker on 3/12/2022.
//

import SwiftUI

struct SignUpPasswordView: View {
    @Binding var signUpUsername: String
    @Binding var signUpEmail: String
    @Binding var signUpFirstName: String
    @Binding var signUpLastName: String
    @Binding var showOnboardingView: Bool

    @State var signUpPassword: String = ""
    @State var signUpPasswordConfirm: String = ""

    let _friendsService = FriendsService();
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Password:")
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                .padding(.top, 20)
                SecureField("Enter your password", text: $signUpPassword)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
            }
            HStack {
                Text("Re-enter your Password:")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 5)
            .padding(.top, 20)
            SecureField("Re-enter your password", text: $signUpPasswordConfirm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .padding(.bottom, 25)
            Button("Sign up") {
                Task {
                    let success: Bool = await CreateUser(userName: signUpUsername, password: signUpPassword, email: signUpEmail, firstName: signUpFirstName, lastName: signUpLastName)
                    print(success)
                    if success == true {
                        signalR.connection.start()
                        dataState.currentUserName = signUpUsername
                        UserDefaults.standard.set(dataState.currentUserName, forKey: "userName")
                        dataState.currentUser = await GetUser()
                        dataState.friendsList = await _friendsService.GetFriendsList()
                        // TODO: Add loading state
                        showOnboardingView = false
                    }
                }
            }
            .id(1)
            .buttonStyle(.borderedProminent)
            .padding(.top, 20)
        }
    }
}

struct SignUpPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPasswordView(signUpUsername: .constant("user"), signUpEmail: .constant("user"), signUpFirstName: .constant("user"), signUpLastName: .constant("user"), showOnboardingView: .constant(true))
    }
}
