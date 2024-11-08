//
//  4Celebrate.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import SwiftUI

struct _Celebrate: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("Celebrate Life 🥳")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    Text("\"The more you celebrate your life, the more there is in life to celebrate.\" \n– Oprah Winfrey")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    Text("You're all set to start your journey! Celebrate every good thing—big or small.🌟")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to MyNotesView
                    NavigationLink(destination: _NoAds()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 30)
                                .foregroundStyle(Color.black)
                                .shadow(radius: 5)
                            Text("Done")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.champagnePink)
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
    _Celebrate()
}
