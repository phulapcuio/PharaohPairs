//
//  LeadService.swift
//  Egypt


import Foundation

enum LeadServiceError: Error {
    case unkonwn
    case noData
}

class LeadService {

    static let shared = LeadService()
    private init() {}
    
    private let urlString = "https://go.aviator-club.space/users/leaderboard"

    func fetchData(successCompletion: @escaping(ModelLead) -> Void, errorCompletion: @escaping (Error) -> Void) {

        guard let url = URL(string: urlString) else {
            print("Неверный URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
     
        
        guard let token = AuthTokenService.shared.token else { return }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
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
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            
            do {
                let decoder = JSONDecoder()
                let leadModel = try decoder.decode(ModelLead.self, from: data)
                DispatchQueue.main.async {
                    successCompletion(leadModel)
                    print("\(leadModel)")
                }
            }catch {
                print("error - ", error)
                
                DispatchQueue.main.async {
                    errorCompletion(error)
                }
            }
        }
        task.resume()
    }
}
