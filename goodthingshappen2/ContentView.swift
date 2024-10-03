//
//  ContentView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/21/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth
import RevenueCat
import RevenueCatUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note6]
    @Query private var user: [User3]
    
    @State private var showPaywall = false
    @State private var hasPremium: Bool = false

    var body: some View {
        if !appState.isLoggedIn {
            LandingView()
        } else {
            TabView {
                MyNotesView()
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }
                
                FeedAccessView(hasPremium: hasPremium)
                    .tabItem {
                        Label("Feed", systemImage: "newspaper")
                    }
                    .onAppear {
                        Task {
                            await checkPremiumStatus()
                        }
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.icloud.fill")
                    }
            }
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView( displayCloseButton: true, performRestore: {
                    await performRestore() // Call the async function
                })
            }
        }
    }

    func performRestore() async -> (success: Bool, error: (any Error)?) {
        do {

            let restored = try await Purchases.shared.restorePurchases()
            
            // Check if restore was successful
            if restored.entitlements.all["premium"]?.isActive == true {
                showPaywall = false // Dismiss the paywall
                return (true, nil)
            } else {
                return (false, nil) // Restore failed, but no error
            }
        } catch {
            return (false, error) // Return the error if any occurred
        }
    }
    
    // Function to check the user's subscription status
    func checkPremiumStatus() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            hasPremium = customerInfo.entitlements.all["premium"]?.isActive == true
            if !hasPremium {
                showPaywall = true
            }
        } catch {
            print("Failed to check premium status: \(error)")
        }
    }
}

struct FeedAccessView: View {
    var hasPremium: Bool

    var body: some View {
        if hasPremium {
            FeedView()
        } else {
            Text("You need premium access to view the feed.")
                .foregroundColor(.gray)
                .font(.headline)
                .padding()
        }
    }
}


