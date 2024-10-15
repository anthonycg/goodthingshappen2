//
//  1BoostHappy.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import SwiftUI

struct _BoostHappy: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("Happiness Boost 😊")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    Text("Research shows that taking just a few moments each day to reflect on the good things in life can boost your happiness and well-being.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 30)
                    
                    Text("Whether it’s something small or big, recording these moments can help shift your focus to the positive and build lasting mental resilience.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 90)
                    
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to push to the next screen
                    NavigationLink(destination: _HowItWorks()) {
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
    _BoostHappy()
}

