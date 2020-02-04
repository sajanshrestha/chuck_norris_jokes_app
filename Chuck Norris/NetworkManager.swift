//
//  NetworkManager.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/5/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    private static var baseUrl = "http://localhost:5000"
    
        
    static func getRandomJoke(_ category: Category, completion: @escaping (Joke?, Error?) -> Void) {
        
        guard let url = getURL(for: category)?.url else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error!)
                return
            }
            guard let joke = try? JSONDecoder().decode(Joke.self, from: data) else { return }
            completion(joke, nil)
        }.resume()
    }
    
    static func createUser(with username: String) {
        
        let userDict = ["username": username]
        
        guard let url = URL(string: baseUrl + "/user/new") else {return}
        
        print(url)
                        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userDict, options: []) else {return}
        
        request.httpBody = httpBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request).resume()
        
        let defaults = UserDefaults.standard
        
        defaults.set(username, forKey: "username")
                
    }
    
    static func likeJoke(jokeID: Int, userId: Int) {
        
        let likeDict = ["user_id": userId , "joke_id": jokeID]
        
        guard let url = URL(string: baseUrl + "/jokes") else {return}
        
        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        guard let httpBody = try? JSONSerialization.data(withJSONObject: likeDict, options: []) else {return}

        request.httpBody = httpBody

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request).resume()
    }
    
    static func getUser(with username: String, completion: @escaping (User?, Error?) -> Void) {
        
        guard let url = URL(string: baseUrl + "/users") else {return}
                
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            guard let users = try? JSONDecoder().decode([User].self, from: data) else {return}
            
            let userList = users.filter {$0.username == username}
            
            completion(userList.first, nil)
            
        }.resume()
        
    }
    
    static func getLikedJokes(for user: User, completion: @escaping ([Joke]?, Error?) -> Void) {
        
        guard let url = URL(string: "http://localhost:5000/jokes/liked_jokes?user_id=\(user.id)") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            guard let jokes = try? JSONDecoder().decode([Joke].self, from: data) else {return}
            
            completion(jokes, nil)
        }.resume()
        
    }
    
    static func deleteLikedJoke(_ userId: Int, _ jokeId: Int) {
        
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = "/jokes"
        urlComponent?.queryItems = [URLQueryItem(name: "user_id", value: "\(userId)"), URLQueryItem(name: "joke_id", value: "\(jokeId)")]
                                
        guard let url = urlComponent?.url else {return}
        var request = URLRequest(url: url)        
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request).resume()
        
    }
    
    static func getURL(for category: Category) -> URLComponents? {
        
        var urlComponents = URLComponents(string: baseUrl)
        
        let name = "category"
        var value = ""
                
        switch category {
        case .animal:
            value = Category.animal.rawValue
        case .dev:
            value = Category.dev.rawValue
        case .political:
            value = Category.political.rawValue
        case .religion:
            value = Category.religion.rawValue
        }
        urlComponents?.path = "/jokes/random"
        urlComponents?.queryItems = [URLQueryItem(name: name, value: value)]
        return urlComponents
    }
    
}

