//
//  modelLead.swift
//  Egypt
//
import Foundation

struct ModelLead: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let userID, balance: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case balance
        case imageURL = "imageUrl"
    }
}
