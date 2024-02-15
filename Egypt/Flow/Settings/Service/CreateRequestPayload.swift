//
//  CreateRequestPayload.swift
//  Egypt


import Foundation

struct CreateResponse: Decodable {
    let data: CreateResponseData
}

struct CreateResponseData: Decodable {
    let userId: Int
    let userName: String?
    let balance: Int
    let imageUrl: String
}


struct UpdatePayload: Decodable {
    let data: UpdatePayloadData
}

struct UpdatePayloadData: Decodable {
    let userName: String
    let userId: String
}

struct UpdatePayloadName: Decodable {
    let data: UpdatePayloadNameData
}

struct UpdatePayloadNameData: Decodable {
    let userId: String
}

struct UserNameUpdate: Codable {
    let userName: String
}
