//
//  SignInUpView.swift
//  StatusApp
//
//  Created by Matthew Parker on 29/11/2022.
//

import SwiftUI

struct SignInUpView: View {
    @State var signInUsername: String = ""
    @State var signInPassword: String = ""
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
                    Button("Sign in") {}
                        .buttonStyle(.borderedProminent)
                }

                Spacer()
                Text("Don't have an account?")
                    .padding(.bottom, 12)
                NavigationLink {
                    SignUpView()
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
        SignInUpView()
    }
}
