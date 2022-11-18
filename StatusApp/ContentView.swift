//
//  ContentView.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataState: DataState
    @State var userView: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { userView.toggle() }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(.leading, 15)
                    }
                    Spacer()
                    Text("Status")
                        .font(.title)
                    Spacer()
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .shadow(radius: 5)
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 15)
                }
                Spacer()
                Image(systemName: "person")

                NavigationLink {
                    ProfileView()
                } label: {
                    Text("Profile View")
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $userView) {
                    ProfileView()
                }
                .padding()
                .task {
                    await dataState.currentUser = GetUser(AccountId: 1)
                }
                Spacer()
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
