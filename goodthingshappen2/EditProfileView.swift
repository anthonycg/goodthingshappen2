//
//  EditProfileView.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/25/24.
//

import SwiftUI
import SwiftData
import FirebaseAuth
import UserNotifications

struct EditProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    @State private var NotificationsOn: Bool = UserDefaults.standard.bool(forKey: "LocalNotificationsOn")
    @Query var users: [User5]
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""

    var body: some View {
        ZStack {
            Color.champagnePink.ignoresSafeArea()

            VStack {
                Text("Edit Profile")
                    .font(.title)
                    .padding(.bottom)
                    .foregroundStyle(.black)

                Spacer()

                let firstUser = users.first
                VStack(alignment: .leading, spacing: 16) {
                    Text("Name")
                        .foregroundStyle(.gray)
                    TextField("Name", text: $name)
                        .foregroundStyle(.black)
                        .onAppear {
                            name = firstUser?.name ?? ""
                        }
                    Divider().background(Color.black)

                    Text("Email")
                        .foregroundStyle(.gray)
                    TextField("Email", text: $email)
                        .onAppear {
                            email = Auth.auth().currentUser?.email ?? ""
                        }
                        .foregroundStyle(.black)
                        .disabled(true)
                    Divider().background(Color.black)

                    Button("Done") {
                        updateUser(users.first!)
                    }

                    // Toggle for local notifications
                    HStack {
                        Toggle("Notifications", isOn: $NotificationsOn)
                            .onChange(of: NotificationsOn) { value in
                                toggleNotifications(value)
                            }
                            .frame(width: 200)
                            .foregroundStyle(.black)
                    }
                    .padding()

                    Spacer()
                }
                .padding()
            }
            .padding()
        }
    }

    // Handle the toggle change for local notifications
    func toggleNotifications(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: "LocalNotificationsOn")

        if isEnabled {
            // Request permission for local notifications
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    scheduleLocalNotification()
                } else if let error = error {
                    print("Error requesting notification permissions: \(error)")
                }
            }
        } else {
            cancelLocalNotifications()
        }
    }

    // Schedule a local notification
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Check out the good things that happened today!"
        content.sound = .default

        // Trigger the notification to fire daily at a specific time (e.g., 8 PM)
        var dateComponents = DateComponents()
        dateComponents.hour = 20  // 8:00 PM
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled.")
            }
        }
    }

    // Cancel all local notifications
    func cancelLocalNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("All local notifications canceled.")
    }

    func updateUser(_ user: User5) {
        user.name = name
        user.email = email

        do {
            try modelContext.save()
            let userState = UserState(id: user.id, name: name, email: email, profileImg: "")
            userManager.setUser(user: userState)

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
