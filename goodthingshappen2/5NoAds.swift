//
//  5NoAds.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/14/24.
//

import SwiftUI

struct _NoAds: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("No Ads")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    Text("We don't believe in ads.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    Text("Mental health is maybe more important than ever.")
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
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to MyNotesView
                    NavigationLink(destination: _ScheduleNotification()) {
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
    _NoAds()
}
