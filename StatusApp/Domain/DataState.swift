//
//  DataState.swift
//  StatusApp
//
//  Created by Matthew Parker on 17/11/2022.
//

import Foundation
import SwiftUI

class DataState: ObservableObject {
    @Published var currentUser: User = User();
    @Published var currentAccount: Account = Account();
    @Published var friendsList: [User] = []
}
