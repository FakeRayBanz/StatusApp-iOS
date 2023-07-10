
import Foundation

class FriendsClient: IFriendsClient {
    func GetFriendsList() async -> [User] {
        var friendsList: [User] = []
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/getfriends")
        else {
            print("Invalid URL")
            return friendsList
        }
        urlComponents.queryItems = []

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return friendsList
        }

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
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/sendfriendrequest")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName)]

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
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
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/getfriendships")
        else {
            print("Invalid URL")
            return friendships
        }
        urlComponents.queryItems = []

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return friendships
        }
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
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/actionfriendrequest")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName),
                                    URLQueryItem(name: "accepted", value: String(accepted))]

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
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
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/removefriend")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = [URLQueryItem(name: "friendUserName", value: friendUserName)]

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
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
