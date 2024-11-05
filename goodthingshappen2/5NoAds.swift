//
//  NoAds.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/14/24.
//

import SwiftUI
import RevenueCatUI
import RevenueCat

struct _NoAds: View {
    @State private var isShowingPaywall = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea() // Background color

                ScrollView {
                    VStack(spacing: 20) {
                        Text("Before we get started, here's a brief note on our pricing:")
                            .font(.title3)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 20)
                        
                        Group {
                            Text("We do not believe in ads.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("We want our apps to feel as simple and uncluttered as possible. When practicing gratitude, a clean, distraction-free setting is essential, and ads detract from the experience we want to provide.")
                                .foregroundColor(.black)
                                .lineSpacing(5)
                        }
                        
                        Group {
                            Text("The vast majority of the app is free.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("Everyone can access the app's basic features, and we'd love to keep it that way. We are also aware that mental wellness is more crucial now than ever. 💛")
                                .foregroundColor(.black)
                                .lineSpacing(5)

                        }
                        
                        Group {
                            Text("We are a self-funded team of 2.")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("The only option we have for maintaining this app (while making it accessible to those who might need it most) without ads is through premium subscriptions. Please consider supporting us that way if you like what we do. We would be grateful for your support. 😊")
                                .foregroundColor(.black)
                                .lineSpacing(5)
                        
                        }
                        
                        // NavigationLink to continue
                        NavigationLink(
                            destination: _ScheduleNotification(isShowingPaywall: isShowingPaywall)
                        ) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 180, height: 40)
                                    .foregroundColor(.black)
                                    .shadow(radius: 5)
                                
                                Text("Let's get started!")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.champagnePink)
                                    .font(.headline)
                            }
                        }
                        .padding(.top, 30)

                    }
                    .padding(50)
                }
            }
        }
    }
}

#Preview {
    _NoAds()
}
