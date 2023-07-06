//
//  MessagesRequest.swift
//  StatusApp
//
//  Created by Matthew Parker on 16/11/2022.
//

import Foundation

class MessagingService {
    let _messagesClient: IMessagingClient;
    
    init() {
        _messagesClient = serviceContainer.Resolve(interface: IMessagingClient.self) as! any IMessagingClient;
    }
    
    
    func GetMessages(GroupId: UUID) async -> [Message] {
        let messages = await _messagesClient.GetMessagesAsync(GroupId: GroupId);

        return messages;
    }
}
