
import Foundation

// Messages HTTP Client
class MessagingClient : IMessagingClient  {
    func GetMessagesAsync(GroupId: UUID) async -> [Message] {
        var messages: [Message] = [];
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/getmessages")!;
        urlComponents.queryItems = [URLQueryItem(name: "groupId", value: GroupId.uuidString)];
        let url = urlComponents.url!;
        
        let (data, _) = try! await URLSession.shared.data(from: url)
        
        messages = try! JSONDecoder().decode([Message].self, from: data);
        
        return messages
    }
}
