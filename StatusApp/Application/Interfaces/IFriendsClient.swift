
import Foundation

protocol IFriendsClient {
    func GetFriendsList() async -> [User];
    func SendFriendRequest(friendUserName: String) async -> Bool;
    func GetFriendships() async -> [Friendship];
    func ActionFriendRequest(friendUserName: String, accepted: Bool) async -> Bool;
    func RemoveFriend(friendUserName: String) async -> Bool;
}
