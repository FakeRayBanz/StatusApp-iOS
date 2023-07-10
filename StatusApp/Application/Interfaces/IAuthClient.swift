
import Foundation

protocol IAuthClient {
    func CheckAuth() async -> Bool;
    func SignOut() async -> Bool;
    func SignInRequest(userName: String, password: String) async -> Bool;
}
