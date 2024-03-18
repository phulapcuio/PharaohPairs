////
////  AuthTokenService.swift
////  Egypt
//

//import Foundation
//class AuthTokenService {
//    
//    static let shared = AuthTokenService()
//    
//    var token: String?
//    
//    let username = "admin"
//    let password = "lC2Pg9wg9raXigOZn9Y1"
//    let url = URL(string: "https://bonzala.space/login")!
//    var request: URLRequest
//    
//    init() {
//        request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let loginString = "\(username):\(password)"
//        if let loginData = loginString.data(using: String.Encoding.utf8) {
//            let base64LoginString = loginData.base64EncodedString(options: [])
//            print("Login: \(base64LoginString)")
//            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        }
//    }
//    
//    struct AuthResponse: Codable {
//        let token: String?
//    }
//
//    func authenticate() async throws {
//        do {
//            let config = URLSessionConfiguration.default
//                   config.urlCache = nil
//                   config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
//                   let session = URLSession(configuration: config)
//            let (data, _) = try await session.data(for: request)
//            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
//            self.token = authResponse.token
//        } catch {
//            throw error
//        }
//    }
//}
//
import Foundation

class AuthRequestService {
    
    static let shared = AuthRequestService()
    
    var token: String?
    
    let username = "admin"
    let password = "lC2Pg9wg9raXigOZn9Y1"
    let url = URL(string: "https://pharaoh-pair-backend-070e54f82200.herokuapp.com/login")!
    var request: URLRequest
    
    init() {
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginString = "\(username):\(password)"
        if let loginData = loginString.data(using: String.Encoding.utf8) {
            let base64LoginString = loginData.base64EncodedString(options: [])
            print("Login: \(base64LoginString)")
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
    }
    
    struct AuthResponse: Codable {
        let token: String?
    }

    func authenticate() async throws -> AuthResponse {
        do {
            let config = URLSessionConfiguration.default
                   config.urlCache = nil
                   config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
                   let session = URLSession(configuration: config)
            let (data, _) = try await session.data(for: request)
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            self.token = authResponse.token
            return authResponse
        } catch {
            throw error
        }
    }
}

