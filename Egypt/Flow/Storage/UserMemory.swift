//
//  UserMemory.swift
//  Egypt
//

import Foundation

class UserMemory {
    
    static let shared = UserMemory()
    
    private let defaults = UserDefaults.standard
    
    var scoreCoints: Int {
        get {
            return defaults.integer(forKey: "scoreCoints")
        }
        set {
            updateCoins()
            defaults.set(newValue, forKey: "scoreCoints")
        }
    }
    
    var scoreLevel: Int {
        get {
            return defaults.integer(forKey: "scoreLevel", defaultValue: 1)
        }
        set {
            defaults.set(newValue, forKey: "scoreLevel")
        }
    }
    
    var scoreLife: Int {
        get {
            return defaults.integer(forKey: "scoreLife", defaultValue: 2)
        }
        set {
            defaults.set(newValue, forKey: "scoreLife")
        }
    }
    
    var lastBonusDate: Date? {
        get {
            return defaults.object(forKey: "lastBonusDate") as? Date
        }
        set {
            defaults.set(newValue, forKey: "lastBonusDate")
        }
    }
    
    var isOpen: Bool {
        get {
            return defaults.bool(forKey: "isOpen")
        }
        set {
            defaults.set(newValue, forKey: "isOpen")
        }
    }
    
    var userName: String? {
        get {
            return defaults.string(forKey: "userName")
        }
        set {
            defaults.set(newValue, forKey: "userName")
        }
    }
    
    var userID: Int? {
        get {
            return defaults.object(forKey: "userID") as? Int
        }
        set {
            defaults.set(newValue, forKey: "userID")
        }
    }
    
    var token: String? {
        get {
            return defaults.string(forKey: "token")
        }
        set {
            defaults.set(newValue, forKey: "token")
        }
    }
    
    func updateCoins() {
        guard let userID = UserMemory.shared.userID else { return }
        let coins = UserMemory.shared.scoreCoints
        UserApi.updateData(payload: UpdateUserPayload(id: userID, name: nil, score: coins)) { _ in
            
        }
    }
    
    var link: String? {
        get {
            return defaults.string(forKey: "lin")
        }
        set {
            defaults.setValue(newValue, forKey: "lin")
        }
    }
    
}

extension UserDefaults {
    func integer(forKey key: String, defaultValue: Int) -> Int {
        return self.object(forKey: key) as? Int ?? defaultValue
    }
}
