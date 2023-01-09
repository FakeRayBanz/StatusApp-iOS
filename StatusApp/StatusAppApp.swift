//
//  StatusAppApp.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import SwiftUI

@main
struct StatusAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataState)

//                    This allows code to be run for about 5 seconds when the app is terminated.
//                    Websocket connections are terminated in the background anyway so scenePhase change to .background can
//                    be used to close the SignalR Connection
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
//                    print("App Terminating")
//                }
        }
    }
}
