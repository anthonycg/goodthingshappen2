//
//  goodthingshappen2App.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 9/21/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth
import RevenueCat

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        // Configure RevenueCat
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_kADUlQVYqqQCBQPNjYjfglNUHQp")

        return true
    }
}

@main
struct goodthingshappen2App: App {
    
    @StateObject var appState = AppState()
    @StateObject var userManager = UserManager()
    @StateObject private var subscriptionManager = SubscriptionManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note6.self,
            User5.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            container.deleteAllData()
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(subscriptionManager)
                .environmentObject(userManager)
                .onAppear {
                    userManager.initializeUser()
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
