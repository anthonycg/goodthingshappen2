//
//  ProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI

struct ProfileView: View {
    @State var isEditProfileShowing: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                // Profile Image
                Image(systemName: "smiley")
                    .font(.system(size: 100))
                    .foregroundColor(.black)
                
                // User's Name
                Text("Good Things Happen for")
                    .font(.title3)
                    .padding(.top, 8)
                
                Text("You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Edit Profile Button
                Button(action: {
                    isEditProfileShowing = true
                }) {
                    Text("Edit Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 180)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isEditProfileShowing, content: {
                    EditProfileView()
                })
                .padding(.top, 16)
                
                Spacer()
                
                // Additional Information
                Text("Good Things written | 5")
                    .padding(.bottom, 10)
                
                // Contact Us and Logout Buttons
                HStack {
                    Button(action: {
                       if let url = URL(string: "mailto:anthonygibson24@gmail.com?subject=Good Things Happen Feedback") {
                            // Check if the device can open the URL
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            } else {
                                print("Can't open mail client")
                            }
                        }
                    }) {
                        Text("Contact Us")
                            .foregroundColor(.brown)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Logout action
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 50)
                
                // Tab Bar Placeholder
                Spacer()
            }
            .padding(.top, 40)
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.all)
        }
    }
}


#Preview {
    ProfileView()
}
