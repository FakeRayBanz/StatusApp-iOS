
import Foundation

class FriendsService {
    let _friendsClient: IFriendsClient;
    
    init() {
        _friendsClient = FriendsClient();
    }
    
    func GetFriendsList() async -> [User] {
        let result = await _friendsClient.GetFriendsList();
        return result;
    }
    
    func SendFriendRequest(friendUserName: String) async -> Bool {
        let success = await _friendsClient.SendFriendRequest(friendUserName: friendUserName);
        return success;
    }
    
    func GetFriendships() async -> [Friendship] {
        let result = await _friendsClient.GetFriendships();
        return result;
    }
    
    func ActionFriendRequest(friendUserName: String, accepted: Bool) async -> Bool {
        let success = await _friendsClient.ActionFriendRequest(friendUserName: friendUserName, accepted: accepted);
        return success;
    }
    
    func RemoveFriend(friendUserName: String) async -> Bool {
        let success = await _friendsClient.RemoveFriend(friendUserName: friendUserName);
        return success;
    }
}
