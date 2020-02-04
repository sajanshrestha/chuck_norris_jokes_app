//
//  JokeRow.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/12/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct JokeRow: View {
    
    var joke: String
    
    var body: some View {
        HStack {
            Text(joke)
        }
    }
}

struct JokeRow_Previews: PreviewProvider {
    static var previews: some View {
        JokeRow(joke: "Joke")
    }
}
