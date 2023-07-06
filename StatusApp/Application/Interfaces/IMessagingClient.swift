
import Foundation

protocol IMessagingClient {
    func GetMessagesAsync(GroupId: UUID) async -> [Message];
}
