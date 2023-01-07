//
//  FriendsStatusView.swift
//  StatusApp
//
//  Created by Matthew Parker on 20/11/2022.
//

import SwiftUI

struct FriendsStatusView: View {
    @EnvironmentObject var dataState: DataState
    var statusRed = Color(UIColor(red: 0.96, green: 0, blue: 0, alpha: 1))
    var body: some View {
        ForEach(dataState.friendsList, id: \.userName) { friend in
            NavigationLink {
                ChatView(friend: friend)
            } label: {
                HStack {
                    VStack {
                        Text("\(friend.firstName) \(friend.lastName)")
                            .bold()
                        Text(friend.status)
                            .foregroundColor(.primary)
                    }
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(friend.online ? .green : statusRed)
                        .shadow(radius: 5)
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(5)
            }
        }
    }
}

struct FriendsStatusView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsStatusView()
            .environmentObject(DataState())
    }
}
