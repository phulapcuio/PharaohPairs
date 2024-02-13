//
//  CreateRequestPayload.swift
//  Egypt


import Foundation

struct CreateResponse: Decodable {
    let data: CreateResponseData
}

struct CreateResponseData: Decodable {
    let userId: Int
    let balance: Int
    let imageUrl: String
}


struct UpdatePayload: Encodable {
    
    let name: String?
    let score: Int?
}
