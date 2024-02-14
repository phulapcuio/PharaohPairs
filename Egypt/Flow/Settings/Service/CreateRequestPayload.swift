//
//  CreateRequestPayload.swift
//  Egypt


import Foundation

struct CreateResponse: Decodable {
    let data: CreateResponseData
}

struct CreateResponseData: Decodable {
    let userId: String
    let balance: String
}


struct UpdatePayload: Encodable {
    let data: UpdatePayloadData
}

struct UpdatePayloadData: Encodable {
    let userId: Int
    let balance: Int
}
