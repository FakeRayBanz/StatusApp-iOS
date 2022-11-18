//
//  ProfileView.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataState: DataState
    var body: some View {
        VStack {
            Text(String(dataState.currentUser.accountId ?? -1))
            Text(dataState.currentUser.firstName ?? "null")
            Text(dataState.currentUser.lastName ?? "null")
            Text(dataState.currentUser.email ?? "null")
            Text(dataState.currentUser.password ?? "null")
            Text(dataState.currentUser.userName ?? "null")
            Text(dataState.currentUser.phoneNumber ?? "null")
            Text(dataState.currentUser.status ?? "null")
            Text(String(dataState.currentUser.online ?? false))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
