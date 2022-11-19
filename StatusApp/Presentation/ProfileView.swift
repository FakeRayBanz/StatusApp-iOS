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
            Text(String(dataState.currentUser.accountId))
            Text(dataState.currentUser.firstName)
            Text(dataState.currentUser.lastName)
            Text(dataState.currentAccount.email)
            Text(dataState.currentAccount.password)
            Text(dataState.currentUser.userName)
            Text(dataState.currentAccount.phoneNumber)
            Text(dataState.currentUser.status)
            Text(String(dataState.currentUser.online))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
