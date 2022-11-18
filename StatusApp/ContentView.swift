//
//  ContentView.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataState: DataState
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ProfileView()
                } label: {
                    Text("Profile View")
                }
                .buttonStyle(.borderedProminent)

                ProfileView()
                    .padding()
                    .task {
                        await dataState.currentUser = GetUser()
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataState())
    }
}
