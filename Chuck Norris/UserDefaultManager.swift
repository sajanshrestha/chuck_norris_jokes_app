//
//  UserDefaultManager.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/12/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

import Foundation

struct UserDefaultManager {
    
    private static let defaults = UserDefaults.standard
    
    static func getUser() -> User? {
        guard let savedUser = defaults.object(forKey: "user") as? Data else {return nil}
        guard let user = try? JSONDecoder().decode(User.self, from: savedUser) else {return nil}
        return user
    }
    
    static func saveUser(_ user: User) {
        guard let data = try? JSONEncoder().encode(user) else {return}
        defaults.set(data, forKey: "user")
    }
    
}
