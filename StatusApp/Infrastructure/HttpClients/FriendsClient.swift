
import Foundation

class FriendsClient: IFriendsClient {
    func GetFriendsList() async -> [User] {
        var friendsList: [User] = []
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/getfriends")!;

        urlComponents.queryItems = [];

        let url = urlComponents.url!;

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                friendsList = decodedResponse
            }
        } catch {
            print("Invalid Data")
        }
        return friendsList
    }

    func SendFriendRequest(friendUserName: String) async -> Bool {
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/sendfriendrequest")!;
        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName)];

        let url = urlComponents.url!;
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let (_, info) = try await URLSession.shared.data(for: request)
            if let httpResponse = info as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 200 {
                    // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                    // friendship = decodedResponse
                    return true

                } else {
                    return false
                }
            }
        } catch {
            print("Invalid Data")
            return false
        }
        return false
    }

    func GetFriendships() async -> [Friendship] {
        var friendships: [Friendship] = []
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/getfriendships")!;

        urlComponents.queryItems = [];

        let url = urlComponents.url!;

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([Friendship].self, from: data) {
                friendships = decodedResponse
            }
        } catch {
            print("Invalid Data")
        }
        return friendships
    }

    func ActionFriendRequest(friendUserName: String, accepted: Bool) async -> Bool {
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/actionfriendrequest")!;
        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName),
                                    URLQueryItem(name: "accepted", value: String(accepted))];

        let url = urlComponents.url!;

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        do {
            let (_, info) = try await URLSession.shared.data(for: request)
            if let httpResponse = info as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // TODO: Update Friendship here
                    // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                    // friendship = decodedResponse
                    return true

                } else {
                    return false
                }
            }
        } catch {
            print("Invalid Data")
            return false
        }
        return false
    }

    func RemoveFriend(friendUserName: String) async -> Bool {
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/removefriend")!;

        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName)];

        let url = urlComponents.url!;

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        do {
            let (_, info) = try await URLSession.shared.data(for: request)
            if let httpResponse = info as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                    // friendship = decodedResponse
                    return true

                } else {
                    return false
                }
            }
        } catch {
            print("Invalid Data")
            return false
        }
        return false
    }
}
