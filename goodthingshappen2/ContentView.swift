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
    @Query private var notes: [Note4]
    @Query private var user: [User3]
    @State private var showPaywall = false

    var body: some View {
        if (!appState.isLoggedIn) {
            LandingView()
        } else {
            TabView {
                MyNotesView()
                    .tabItem {
                        Label("Notes", systemImage: "note.text")
                    }
                
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "newspaper")
                    }
                    .onAppear {
                        checkSubscriptionStatus()
                    }
                    .fullScreenCover(isPresented: $showPaywall) {
                        PaywallView(displayCloseButton: false)
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.icloud.fill")
                    }
            }
        }
    }

    // Function to check the user's subscription status
    func checkSubscriptionStatus() {
        Task {
            do {
                let customerInfo = try await Purchases.shared.customerInfo()
                if customerInfo.entitlements.all["premium"]?.isActive != true {
                    showPaywall = true
                }
            } catch {
                print("Failed to fetch customer info: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Note4.self, User3.self], inMemory: false)
        .environmentObject(AppState())
}

