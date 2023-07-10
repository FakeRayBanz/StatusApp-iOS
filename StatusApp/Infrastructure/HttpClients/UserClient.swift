
import Foundation

class UserClient: IUserClient {
    func CreateUser(userName: String, password: String, email: String, firstName: String, lastName: String) async -> Bool {
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/createuser")
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
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        do {
            let dto = CreateUserDto()
            dto.userName = userName
            dto.firstName = firstName
            dto.lastName = lastName
            dto.email = email
            dto.password = password

            let jsonData = try encoder.encode(dto)
            request.httpBody = jsonData
            let (_, info) = try await URLSession.shared.data(for: request)
            if let httpResponse = info as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // if let decodedResponse = try? JSONDecoder().decode(Friendship.self, from: data) {
                    // friendship = decodedResponse
                    print("Created successfully")
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

    func UpdateUser(user: User) async -> Bool {
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/updateuser")
        else {
            print("Invalid URL")
            return false
        }
        let queryItems: [URLQueryItem] = []
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return false
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()

        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
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

    func GetUser() async -> User {
        var user = User()
        guard var urlComponents = URLComponents(string: "\(apiBaseUrl)/getuser")
        else {
            print("Invalid URL")
            return User()
        }
        urlComponents.queryItems = []

        guard let url = urlComponents.url
        else {
            print("Invalid URL")
            return User()
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                user = decodedResponse
            }
        } catch {
            print("Invalid Data")
        }
        return user
    }
}
