//
//  ContentView.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/5/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct JokeView: View {
    
    
    @State private var joke = ""
    @State private var jokeLiked = false
    @State private var selectedCategory = 0
    @State private var hasUsername = false
    
    @State private var userID = 0
    @State private var jokeId = 0
    
    var categories: [Category] = [.animal, .political, .religion, .dev]
    
    var body: some View {
            ZStack {
                Background()
                VStack {
                                        
                    Picker(selection: $selectedCategory, label: Text("")) {
                        ForEach(0 ..< categories.count) {
                            Text(self.categories[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(EdgeInsets(top: 24, leading: 8, bottom: 0, trailing: 8))
                    
                    Spacer()
                
                    Text(joke)
                        .font(.headline)
                        .frame(height: 300)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    HStack {
                        Image(systemName: jokeLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.largeTitle)
                            .foregroundColor(jokeLiked ? .green : .gray)
                            .offset(y: jokeLiked ? UIScreen.main.bounds.height : 0)
                            .animation(Animation.easeInOut(duration: 2).delay(0.2))
                            .onTapGesture {
                                self.jokeLiked.toggle()
                                if self.jokeLiked {
                                    guard let user = UserDefaultManager.getUser() else {return}
                                    NetworkManager.likeJoke(jokeID: self.jokeId, userId: user.id)
                                }
                        }
                        Spacer()
                        
                        Image(systemName: "arrow.clockwise")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                self.loadJoke()
                        }
                    }
                    .padding(.horizontal)
                        
                    Spacer()

                }
            .onAppear {
                self.loadJoke()
            }
        }
    }
}

extension JokeView {
    
    func loadJoke() {
        
        self.jokeLiked = false
        NetworkManager.getRandomJoke(categories[selectedCategory]) { (joke, error) in
            guard let joke = joke else { return }
            self.joke = joke.content
            self.jokeId = joke.id
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
