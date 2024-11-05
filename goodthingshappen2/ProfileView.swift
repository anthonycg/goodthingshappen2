//
//  ProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI
import FirebaseAuth
import SwiftData
import RevenueCat

struct ProfileView: View {
    @State var isEditProfileShowing: Bool = false
    @Environment(\.modelContext) var modelContext
    @Query var notes: [Note6]
    @Query var user: [User5]
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userManager: UserManager
    @State private var isSubscribed: Bool = false // New state for subscription status
    
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
                    .foregroundStyle(.black)
                
                Text("\(user.first?.name ?? "You")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
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
                    .foregroundStyle(.black)
                
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
        .onAppear {
            fetchSubscriptionStatus()
        }
    }
    
    // Check the user's subscription status with RevenueCat
    func fetchSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { customerInfo, error in
            if let error = error {
                print("Error fetching subscription status: \(error)")
            } else if let customerInfo = customerInfo {
                // Check if the user is subscribed
                isSubscribed = customerInfo.entitlements["premium"]?.isActive == true
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            appState.isLoggedIn = false
            userManager.logout()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

#Preview {
    ProfileView()
}

