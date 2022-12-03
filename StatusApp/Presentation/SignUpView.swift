//
//  SignUpView.swift
//  StatusApp
//
//  Created by Matthew Parker on 29/11/2022.
//

import SwiftUI

struct SignUpView: View {
    @State var signUpUsername: String = ""
    @State var signUpEmail: String = ""
    @State var signUpFirstName: String = ""
    @State var signUpLastName: String = ""
    @Binding var showOnboardingView: Bool
    var body: some View {
        // TODO: Input Validation
        VStack(spacing: 0) {
            Text("Sign Up")
                .font(.system(size: 25))
                .padding(.bottom, 20)
            Group {
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
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }

                Group {
                    HStack {
                        Text("Email:")
                        Spacer()
                            .italic()
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)

                    TextField("Enter your email", text: $signUpEmail)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                }
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
                    .padding(.bottom, 25)
            }
            NavigationLink {
                SignUpPasswordView(signUpUsername: $signUpUsername, signUpEmail: $signUpEmail, signUpFirstName: $signUpFirstName, signUpLastName: $signUpLastName, showOnboardingView: $showOnboardingView)
            } label: {
                Text("Continue")
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(showOnboardingView: .constant(true))
    }
}
