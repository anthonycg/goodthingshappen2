//
//  EditProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct EditProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State private var NotificationsOn: Bool = false
    @Query var users: [User5]
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""

    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()
                .ignoresSafeArea()

            VStack() {
                Text("Edit Profile")
                    .font(.title)
                    .padding(.bottom)

                Spacer()

                let firstUser = users.first
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Name")
                            .foregroundStyle(.gray)

                        TextField("Name", text: $name)
                            .onAppear {
                                name = firstUser?.name ?? ""
                            }
                        Divider()
                            .background(Color.black)

                        Text("Email")
                            .foregroundStyle(.gray)

                        TextField("Email", text: $email)
                            .onAppear {
                                email = Auth.auth().currentUser?.email ?? ""
                            }
                            .disabled(true)
                        Divider()
                            .background(Color.black)

                        Button("Done") {
                            updateUser(users.first!)
                        }

//                        HStack {
//                            Toggle("Notifications", isOn: $NotificationsOn)
//                                .frame(width: 200)
//                        }
//                        .padding()

//                        Button("Contact Us") {
//                            // Open the email client with pre-populated address
//                            if let url = URL(string: "mailto:your-email@example.com") {
//                                UIApplication.shared.open(url)
//                            }
//                        }
//                        .padding()
//                        .buttonStyle(BorderlessButtonStyle())

                        Spacer()
                    }
                    .padding()
                
            }
            .padding()
        }
    }
    
    func updateUser(_ user: User5) {
        user.name = name
        user.email = email

        do {
            // Swift Data
            try modelContext.save()
            // User State
            let userState = UserState(id: user.id, name: name, email: email, profileImg: "")
            userManager.setUser(user: userState)
            // DB
            guard let userId = Auth.auth().currentUser?.uid else {
                print("couldn't get userId")
                return
            }
            
            guard let url = URL(string: "https://sonant.net/api/user/update") else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            
            print("User ID: \(userId)")
            print("Name: \(name)")

            let user = [
                "id": userId,
                "name": name
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
            }
            
            task.resume()
            
        } catch {
            print("Error saving updated user: \(error)")
        }
        dismiss()
    }
    
}

#Preview {
    EditProfileView()
}
