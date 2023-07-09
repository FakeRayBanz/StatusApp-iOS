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
        }
    }
}
