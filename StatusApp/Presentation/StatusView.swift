//
//  StatusView.swift
//  StatusApp
//
//  Created by Matthew Parker on 19/11/2022.
//

import SwiftUI

struct StatusView: View {
    @EnvironmentObject var dataState: DataState
    var body: some View {
        VStack {
            Text(dataState.currentUser.status)
            TextField("Enter data", text: $dataState.currentUser.status)
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
            .environmentObject(DataState())
    }
}
