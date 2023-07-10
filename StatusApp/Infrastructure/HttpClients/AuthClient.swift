
import Foundation

class AuthClient: IAuthClient {
    func CheckAuth() async -> Bool {
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/checkauth")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = []

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (_, info) = try await URLSession.shared.data(for: request)
            if let httpResponse = info as? HTTPURLResponse {
                // print(httpResponse.statusCode)
                if httpResponse.statusCode == 200 {
                    return true
                } else if httpResponse.statusCode == 401 {
                    // TODO: Prompt sign in
                    return false
                } else {
                    return true
                }
            }
        } catch {
            print("Invalid Data")
            return false
        }
        return false
    }

    func SignOut() async -> Bool {
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/signout")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = []

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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

    func SignInRequest(userName: String, password: String) async -> Bool {
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/signin")
        else {
            print("Invalid URL")
            return false
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "userName", value: userName),
            URLQueryItem(name: "password", value: password)
        ]

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

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
}
