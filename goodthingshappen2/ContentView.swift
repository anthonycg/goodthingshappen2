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
    @Query private var notes: [Note]

    var body: some View {
        if (!appState.isLoggedIn) {
            LandingView()
        } else {
            MyNotesView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Note.self, inMemory: false)
}
