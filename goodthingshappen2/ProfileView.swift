//
//  ProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI
import FirebaseAuth
import SwiftData

struct ProfileView: View {
    @State var isEditProfileShowing: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note6]
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            
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
                Text("Good Things written | \(notes.count)")
                    .padding(.bottom, 10)
                
                // Contact Us and Logout Buttons
                HStack {
                    Button(action: {
                       if let url = URL(string: "mailto:anthonygibson24@gmail.com?subject=Good Things Happen Feedback") {
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
                        logout()
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 50)
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            appState.isLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    ProfileView()
}

