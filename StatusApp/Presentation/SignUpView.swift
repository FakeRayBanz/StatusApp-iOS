//
//  SignUpView.swift
//  StatusApp
//
//  Created by Matthew Parker on 29/11/2022.
//

import SwiftUI

struct SignUpView: View {
    @State var signUpUsername: String = ""
    @State var signUpPassword: String = ""
    @State var signUpPasswordConfirm: String = ""
    @State var signUpFirstName: String = ""
    @State var signUpLastName: String = ""
    var body: some View {
        VStack(spacing: 0) {
            Text("Status")
                .font(.largeTitle)
            Spacer()
            Text("Sign Up")
                .font(.system(size: 25))
                .padding(.top)
                .padding(.bottom, 20)
            Group {
                HStack {
                    Text("Username:")
                    Spacer()
                    Text("This can't be changed later")
                        .italic()
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                TextField("Enter your username", text: $signUpUsername)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
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
            }
            Group {
                HStack {
                    Text("First Name:")
                    Spacer()
                    Text("These can be updated later")
                        .italic()
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom, 5)
                TextField("Enter your first name", text: $signUpFirstName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                HStack {
                    Text("Last Name:")
                    Spacer()
                }
                .padding(.top, 25)
                .padding(.horizontal)
                .padding(.bottom, 5)
                TextField("Enter your last name", text: $signUpLastName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            Button("Sign up") {}
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
