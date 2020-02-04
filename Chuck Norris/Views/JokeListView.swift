//
//  JokeListView.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/11/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct JokeListView: View {
        
    @State private var jokes = [Joke]()
    @State private var userId = 0
    
    var body: some View {
        ZStack {
            Background()
            List {
                ForEach(jokes) { joke in
                    JokeRow(joke: joke.content)
                    }
            .onDelete(perform: delete)
                    .listStyle(GroupedListStyle())
            }
            
        }
        .onAppear {
            
            guard let user = UserDefaultManager.getUser() else {return}
            self.userId = user.id
            NetworkManager.getLikedJokes(for: user) { (jokes, error) in
                guard let jokes = jokes else {return}
                self.jokes = jokes
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        let jokeIds = self.jokes.map {$0.id}
        jokes.remove(atOffsets: offsets)
        let finalJokeIds = self.jokes.map {$0.id}
        let ids = Set(finalJokeIds).symmetricDifference(Set(jokeIds))
        let jokeId = ids.first ?? 0
        NetworkManager.deleteLikedJoke(self.userId, jokeId)
    }
    
    
}

struct JokeListView_Previews: PreviewProvider {
    static var previews: some View {
        JokeListView()
    }
}
