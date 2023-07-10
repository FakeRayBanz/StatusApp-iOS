//
//  StatusView.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject var dataState: DataState
    @State var statusString = ""
    var statusRed = Color(UIColor(red: 0.96, green: 0, blue: 0, alpha: 1))

    let _userService = UserService();
    var body: some View {
        VStack {
            Text("My Status")
                .font(.largeTitle)
                .padding(.top)
                .padding(.bottom, 35)
            HStack {
                VStack {
                    Text("\(dataState.currentUser.firstName) \(dataState.currentUser.lastName)")
                        .bold()
                        .foregroundColor(.blue)
                    Text(dataState.currentUser.status)
                        .foregroundColor(.primary)
                }
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(dataState.currentUser.online ? .green : statusRed)
                    .shadow(radius: 5)
                    .scaledToFit()
                    .frame(width: 35, height: 35)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.bottom, 50)
            HStack {
                ZStack {
                    if dataState.currentUser.online == true {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .frame(width: 56)
                    }
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .shadow(radius: 5)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            Task {
                                dataState.currentUser.online = true
                                let success = await _userService.UpdateUser(user: dataState.currentUser)
                                if success == true {
                                    dataState.currentUser = await _userService.GetUser()
                                }
                            }
                        }
                }
                .padding(.trailing, 30)
                ZStack {
                    if dataState.currentUser.online == false {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .frame(width: 56)
                    }
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(statusRed)
                        .shadow(radius: 5)
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            Task {
                                dataState.currentUser.online = false
                                let success = await _userService.UpdateUser(user: dataState.currentUser)
                                if success == true {
                                    dataState.currentUser = await _userService.GetUser()
                                }
                            }
                        }
                }
            }
            .padding(.bottom, 40)

            Text("Change your status:")
            TextField("Enter data", text: $statusString)
                .frame(minWidth: 100, idealWidth: 200, maxWidth: 250)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.darkGray))
                .font(.system(size: 20))
                .padding(10)
                // .cornerRadius(10)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color(.darkGray), lineWidth: 2)
                )
                .padding(5)
                .onSubmit {
                    Task {
                        dataState.currentUser.status = statusString
                        let success = await _userService.UpdateUser(user: dataState.currentUser)
                        if success == true {
                            dataState.currentUser = await _userService.GetUser()
                        }
                    }
                }
            Spacer()
            Spacer()
            Spacer()
        }
        .task {
            statusString = dataState.currentUser.status
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
            .environmentObject(DataState())
    }
}
