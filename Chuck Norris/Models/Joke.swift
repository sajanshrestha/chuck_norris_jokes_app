//
//  Joke.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/5/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

struct Joke: Codable, Identifiable {
    let id: Int
    let content: String
}
