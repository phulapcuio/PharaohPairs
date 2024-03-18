//
//  UserApiService.swift
//  Egypt
//
//  Created by Dmitriy Holovnia on 18.03.2024.
//

import Foundation

struct CreateUserPayload: Codable {
    let name: String?
    let score: Int
    
    func makeBody() -> String
    {
        var data = [String]()
        data.append("score=\(score)")
        if let name = name {
            data.append("name=\(name)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}

struct UpdateUserPayload: Codable {
    let id: Int
    let name: String?
    let score: Int?
}

struct User: Codable {
    let id: Int
    let name: String?
    let score: Int
}

class UserApi {
    
    static func createUser(payload: CreateUserPayload, completion: @escaping (Result<User, Error>) -> Void) {
        guard let token = UserMemory.shared.token else { return }
        let url = URL(string: "\(Settings.url)/api/players")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = payload.makeBody().data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    print("USER: \(user)")
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                    print("ERROR: \(error.localizedDescription)")
                }
            } else if let error {
                completion(.failure(error))
                print("ERROR: \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    static func updateData(payload: UpdateUserPayload, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(Settings.url)/api/players/\(payload.id)") else {
            return
        }
        guard let token = UserMemory.shared.token else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        
        let json = try? JSONEncoder().encode(payload)
        request.httpBody = json
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode(User.self, from: data)
                    print("MODEL: \(model)")
                    completion(.success(model))
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    static func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let token = UserMemory.shared.token else { return }
        guard let url = URL(string: "\(Settings.url)/api/players/") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode([User].self, from: data)
                    print("MODEL: \(model)")
                    completion(.success(model))
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
