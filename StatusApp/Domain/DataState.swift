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
    @Published var friends: [Friend] = [Friend(accountId: 2,
                                               firstName: "Raymond",
                                               lastName: "Smith",
                                               userName: "RaySmith",
                                               status: "Open to plans",
                                               online: true),
                                        Friend(accountId: 3,
                                               firstName: "Katie",
                                               lastName: "Murray",
                                               userName: "Katieee",
                                               status: "Keen for dinner",
                                               online: true),
                                        Friend(accountId: 4,
                                               firstName: "Jarrod",
                                               lastName: "Lee",
                                               userName: "Jrod1",
                                               status: "Quiet night in",
                                               online: false)]
}
