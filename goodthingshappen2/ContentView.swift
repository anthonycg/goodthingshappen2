//
//  ContentView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/21/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note3]
    @Query private var user: [User2]

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
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.icloud.fill")
                    }
            }        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Note3.self, User2.self], inMemory: false)
        .environmentObject(AppState())
}
