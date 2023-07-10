
import Foundation

protocol IUserClient {
    func CreateUser(userName: String, password: String, email: String, firstName: String, lastName: String) async -> Bool;
    func UpdateUser(user: User) async -> Bool;
    func GetUser() async -> User;
}
