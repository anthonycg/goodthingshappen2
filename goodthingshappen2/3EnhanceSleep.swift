//
//  3EnhanceSleep.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/13/24.
//

import SwiftUI

struct _EnhanceSleep: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("Sleep Better 🛌")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.black)
                        .padding([.bottom], 20)
                    
                    Text("Reflecting on positive moments right before bed can help you fall asleep faster and enjoy more restful sleep.")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    Text("So, grab your journal before bed and let the good things carry you into dreamland!")
                        .font(.headline)
                        .foregroundStyle(Color.black)
                        .lineSpacing(5)
                        .padding([.bottom], 20)
                    
                    HStack {
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10))
                        Image(systemName: "circle")
                            .font(.system(size: 10))
                    }
                    .padding([.bottom], 20)
                    
                    // NavigationLink to push to the next screen
                    NavigationLink(destination: _Celebrate()) {
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
    _EnhanceSleep()
}
