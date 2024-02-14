//
//  PostService.swift
//  Egypt
import Foundation

enum PostServiceError: Error {
    case unkonwn
    case noData
}

class PostService {
    
    static let shared = PostService()
    private init() {}
    private let baseUrl = "https://go.aviator-club.space/users"
    
    func updateData(completion: @escaping (Result<CreateResponse, Error>) -> Void) {
        
        guard let url = URL(string: baseUrl + "/update-balance/\(UserMemory.shared.userID!)/\(UserMemory.shared.scoreCoints)") else {
            completion(.failure(LeadServiceError.unkonwn))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                do {
                    guard let data else { return }
                    let model = try JSONDecoder().decode(CreateResponse.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func createUser(successCompletion: @escaping(CreateResponse) -> Void, errorCompletion: @escaping (Error) -> Void) {
        
        guard let url = URL(string: baseUrl + "/create-user") else {
            print("Неверный URL")
            DispatchQueue.main.async {
                errorCompletion(LeadServiceError.unkonwn)
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(LeadServiceError.noData)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    errorCompletion(LeadServiceError.unkonwn)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userOne = try decoder.decode(CreateResponse.self, from: data)
                DispatchQueue.main.async {
                    successCompletion(userOne)
                    print("successCompletion-\(userOne)")
                }
            }catch {
                print("error", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
}

