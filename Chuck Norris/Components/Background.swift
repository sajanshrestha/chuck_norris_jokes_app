//
//  Background.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/11/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
