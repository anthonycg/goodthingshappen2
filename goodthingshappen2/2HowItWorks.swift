//
//  2HowItWorks.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import SwiftUI

struct _HowItWorks: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("How to 📝")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    Text("**1. Pause & Reflect**\nThink of one good thing from today—it could be anything from a kind gesture to a favorite song.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    Text("**2. Write It Down**\nCapture it in your journal. No need to overthink—just let the good vibes flow.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    Text("**3. Add Details**\nDescribe how you felt, what the day was like, or any little details. You'll love reliving these memories later!")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 50)
                    
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to push to the next screen
                    NavigationLink(destination: _EnhanceSleep()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 30)
                                .foregroundStyle(Color.champagnePink)
                                .border(.black)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                            Text("Next")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black)
                                .font(.headline)
                        }
                    }
                }
                .padding(50)
            }
        }
    }
}

#Preview {
    _HowItWorks()
}

