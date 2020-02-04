//
//  CreateUserView.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/11/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct CreateUserView: View {
    
    @State private var enteredUsername = ""
    @State private var showJokeView = false
    @State private var userCreated = false
    
    var user: User?
    var hasUser: Bool { user != nil }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if hasUser {
                    HomeView()
                }
                else {
                    VStack {
                        Text("Enter a username to get started")
                        
                        TextField("Username", text: $enteredUsername)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        
                        Button("Sign Up") {
                            NetworkManager.createUser(with: self.enteredUsername)
                            self.userCreated = true
                        }
                        .modifier(CustomButton())
                        .disabled(self.userCreated)
                        
                        Button("Get Started") {
                            NetworkManager.getUser(with: self.enteredUsername) { (user, error) in
                                guard let user = user else {return}
                                UserDefaultManager.saveUser(user)
                            }
                            self.showJokeView = true
                        }
                        .modifier(CustomButton())
                        .sheet(isPresented: $showJokeView) {
                            HomeView()
                        }
                    }.padding(.horizontal)
                }
                
            }
            .navigationBarTitle("Jokes")
            
        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
