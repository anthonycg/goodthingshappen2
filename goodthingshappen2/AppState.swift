//
//  AppState.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/26/24.
//

import Foundation
import FirebaseAuth

class AppState: ObservableObject {
    // The @Published property wrapper will notify views when the value changes
    @Published var isLoggedIn: Bool = false

    init() {
        // Set the initial logged-in state based on Firebase authentication status
        self.isLoggedIn = Auth.auth().currentUser != nil
    }

    // Call this function when a user logs in or out
    func updateLoginState() {
        self.isLoggedIn = Auth.auth().currentUser != nil
    }
}



