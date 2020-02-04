//
//  CustomButton.swift
//  Chuck Norris
//
//  Created by Sajan Shrestha on 1/12/20.
//  Copyright © 2020 Sajan Shrestha. All rights reserved.
//

import SwiftUI

struct CustomButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
            .frame(width: UIScreen.main.bounds.width - 10)
            .background(Color.green)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 0))
            
    }
}
