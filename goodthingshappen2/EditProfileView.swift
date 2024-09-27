//
//  EditProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var NotificationsOn: Bool = false
    @Query var users: [User]
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

                if let firstUser = users.first {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Name")
                            .foregroundStyle(.gray)

                        TextField("Name", text: $name)
                            .onAppear {
                                name = firstUser.name
                            }
                        Divider()
                            .background(Color.black)

                        Text("Email")
                            .foregroundStyle(.gray)

                        TextField("Email", text: $email)
                            .onAppear {
                                email = firstUser.email
                            }
                        Divider()
                            .background(Color.black)

                        Button("Done") {
                            updateUser(users.first!)
                        }

                        HStack {
                            Toggle("Notifications", isOn: $NotificationsOn)
                                .frame(width: 200)
                        }
                        .padding()

                        Button("Contact Us") {
                            // Open the email client with pre-populated address
                            if let url = URL(string: "mailto:your-email@example.com") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .padding()
                        .buttonStyle(BorderlessButtonStyle())

                        Spacer()
                    }
                    .padding()
                } else {
                    Text("No user found")
                    Button("Test", action: {
                        print(users)
                    })
                    .padding()
                }
            }
            .padding()
        }
    }

    func updateUser(_ user: User) {
        user.name = name
        user.email = email

        do {
            try modelContext.save()
        } catch {
            print("Error saving updated user: \(error)")
        }
        dismiss()
    }
}

#Preview {
    EditProfileView()
}
