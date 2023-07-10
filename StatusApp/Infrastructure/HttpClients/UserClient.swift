
import Foundation

class UserClient: IUserClient {
    func CreateUser(userName: String, password: String, email: String, firstName: String, lastName: String) async -> Bool {
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/createuser")!;

        urlComponents.queryItems = [];

        let url = urlComponents.url!;
        var request = URLRequest(url: url);
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
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/updateuser")!;

        let queryItems: [URLQueryItem] = [];
        urlComponents.queryItems = queryItems;

        let url = urlComponents.url!;
        var request = URLRequest(url: url);
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
        var urlComponents = URLComponents(string: "\(apiBaseUrl)/getuser")!;
        urlComponents.queryItems = [];

        let url = urlComponents.url!;

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
