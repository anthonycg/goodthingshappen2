//
//  NameView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import SwiftUI

struct NameView: View {
    @State var name: String
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            VStack {
                Text("What should we call you?")
                    .font(.largeTitle)
                
                TextField("Enter your name", text: $name)
                
                Divider()
            }
            .frame(width: 200, height: 200)
            .padding()
        }
    }
}

#Preview {
    NameView(name: "")
}
