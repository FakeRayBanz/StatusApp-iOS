//
//  SignInUpView.swift
//  StatusApp
//
//  Created by Matthew Parker on 29/11/2022.
//

import SwiftUI

struct SignInUpView: View {
    @EnvironmentObject var dataState: DataState
    @State var signInUsername: String = ""
    @State var signInPassword: String = ""
    @Binding var showOnboardingView: Bool
    var _authService = AuthService();
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Status")
                    .font(.largeTitle)
                Spacer()
                Text("Sign In")
                    .font(.system(size: 25))
                    .padding(.top)
                    .padding(.bottom, 10)
                Group {
                    HStack {
                        Text("Username:")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    TextField("Enter your username", text: $signInUsername)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    HStack {
                        Text("Password:")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                    SecureField("Enter your password", text: $signInPassword)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    Button("Sign in") {
                        Task {
                            let success = await _authService.SignInRequest(userName: signInUsername, password: signInPassword)
                            print(success)
                            if success == true {
                                signalR.connection.start()
                                dataState.currentUserName = signInUsername
                                UserDefaults.standard.set(dataState.currentUserName, forKey: "userName")
                                dataState.currentUser = await GetUser()
                                dataState.friendsList = await GetFriendsList()
                                dataState.friendships = await GetFriendships()
                                // TODO: Add loading state
                                showOnboardingView = false
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Spacer()
                Text("Don't have an account?")
                    .padding(.bottom, 12)
                NavigationLink {
                    SignUpView(showOnboardingView: $showOnboardingView)
                } label: {
                    Text("Sign up")
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
        }
    }
}

struct SignInUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignInUpView(showOnboardingView: .constant(true))
    }
}
