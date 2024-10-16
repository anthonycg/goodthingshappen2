//
//  6ScheduleNotification.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/14/24.
//

import SwiftUI
import UserNotifications

struct _ScheduleNotification: View {
    @State private var selectedDate = Date()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                Color.champagnePink.ignoresSafeArea()
                VStack {
                    Text("What time would you like to be reminded to write your Good Thing?")
                        .font(.title)
                        .padding()

                    DatePicker("Select Time", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .padding()

                    // Remind me button
                    NavigationLink(destination: MyNotesView()) {
                        Button(action: {
                            requestNotificationAuthorization()
                            scheduleNotification(at: selectedDate)
                            // Update the app state
                            appState.isLoggedIn = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 30)
                                    .foregroundStyle(Color.black)
                                    .shadow(radius: 5)
                                Text("Remind me")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.champagnePink)
                                    .font(.headline)
                            }
                        }
                    }

                    // Skip button
                    NavigationLink(destination: MyNotesView()) {
                        ZStack {
                            Text("Skip")
                                .fontWeight(.light)
                                .foregroundStyle(Color.black)
                                .font(.caption)
                        }
                    }
                }
                .padding()
            }
        }
    }

    func scheduleNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Time to Reflect!"
        content.body = "Don't forget to write down your Good Thing for the day!"
        content.sound = UNNotificationSound.default

        // Create a trigger for the notification at the specified date and time
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        // Create a request to schedule the notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Add the request to the notification center
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted for notifications")
            } else if let error = error {
                print("Error requesting notification permission: \(error)")
            }
        }
    }
}

#Preview {
    _ScheduleNotification()
}
