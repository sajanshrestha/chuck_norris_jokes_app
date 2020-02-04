//
//  HomeView.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/11/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        TabView {
            JokeView()
                .tabItem {
                    Image(systemName: "house")
            }
            
            JokeListView()
                .tabItem {
                    Image(systemName: "star")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
