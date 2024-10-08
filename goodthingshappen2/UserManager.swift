//
//  UserManager.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/7/24.
//

import Foundation
import SwiftUI

class UserManager: ObservableObject {
    @AppStorage("userId") var userId: String = ""
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userEmail") var userEmail: String = ""
    @AppStorage("userProfileImg") var userProfileImg: String = "" // URL as String or Data

    @Published var isLoggedIn: Bool = false
    
    // Initialize user data if available
    func initializeUser() {
        if !userId.isEmpty {
            isLoggedIn = true
        }
    }

    // Update user details when logging in
    func setUser(user: UserState) {
        self.userId = user.id
        self.userName = user.name
        self.userEmail = user.email
        self.userProfileImg = user.profileImg
        self.isLoggedIn = true
    }

    // Clear user details on logout
    func logout() {
        self.userId = ""
        self.userName = ""
        self.userEmail = ""
        self.userProfileImg = ""
        self.isLoggedIn = false
    }
}
