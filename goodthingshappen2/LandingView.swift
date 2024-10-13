//
//  LandingView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/26/24.
//

import SwiftUI
import SwiftData
import CryptoKit
import AuthenticationServices
import FirebaseAuth

struct LandingView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var userManager: UserManager
    @State private var currentNonce: String?
    @Environment(\.modelContext) var modelContext
    @Query var users: [User5]
    
    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
            
            Circle().offset().fill(LinearGradient(gradient: Gradient(colors: [.champagnePink, .white]), startPoint: .topTrailing, endPoint: .bottomLeading))
            
            ZStack {
                Circle().offset(x: -150, y: -350).fill(LinearGradient(gradient: Gradient(colors: [.pinkLace, .white]), startPoint: .bottomLeading, endPoint: .topTrailing))
                
                Circle().offset(x: 150, y: 350).fill(LinearGradient(gradient: Gradient(colors: [.teaGreen, .white]), startPoint: .topTrailing, endPoint: .bottomLeading))
                
                VStack {
                    Spacer()
                    
                    Text("Good Things are happening")
                        .bold()
                        .font(.largeTitle)
                    Text("You should start taking note.")
                        .font(.body)
                    
                    Spacer()
                    
                    SignInWithAppleButton(
                        onRequest: { request in
                            let nonce = randomNonceString()
                            currentNonce = nonce
                            request.requestedScopes = [.fullName, .email]
                            request.nonce = sha256(nonce)
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authorization):
                                handleAuthorization(authorization)
                            case .failure(let error):
                                print("Sign in with Apple failed: \(error.localizedDescription)")
                            }
                        }
                    )
                    .frame(width: 200, height: 45)
                }
            }
        }
    }

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.map { String(format: "%02x", $0) }.joined()
    }
    
    private func handleAuthorization(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            // Create Firebase credential with Apple ID token
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDCredential.fullName)
            
            // Sign in with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Firebase sign in with Apple failed: \(error.localizedDescription)")
                    return
                }
                
                guard let user = Auth.auth().currentUser else {
                    print("Error: User not authenticated")
                    return
                }
                
                let displayName = "\(appleIDCredential.fullName?.givenName ?? "Guest")"
                let email = user.email ?? ""
                let userId = user.uid
                
                // Call createUser here
                createUser(userId: userId, displayName: displayName, email: email)

                // Create User5 object
                let newUser = User5(id: userId, name: displayName, email: email)
                
                // Insert the user into the model context
                modelContext.insert(newUser)
                try? modelContext.save()
                
                let userState = UserState(id: userId, name: displayName, email: email, profileImg: "")
                userManager.setUser(user: userState)
                
                print("User signed in with Apple: \(authResult?.user.uid ?? "")")
                
                // Update the app state
                appState.isLoggedIn = true
            }
        }
    }

    private func createUser(userId: String, displayName: String, email: String) {
        guard let url = URL(string: "https://sonant.net/api/user/create") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        print("User ID: \(userId)")
        print("Display Name: \(displayName)")
        print("Email: \(email)")

        let user = [
            "id": userId,
            "name": displayName,
            "email": email,
        ] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: user, options: [])
        } catch {
            print("Error serializing JSON:", error)
            return
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request:", error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected response:", response ?? "No response")
                return
            }
            
            if let data = data, let responseBody = String(data: data, encoding: .utf8) {
                print("Response body: \(responseBody)")
            }

            print("User created successfully")
        }
        task.resume()
    }
}

#Preview {
    LandingView()
}
