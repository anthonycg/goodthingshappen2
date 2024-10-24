//
//  SubscriptionManager.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/23/24.
//
import Foundation
import RevenueCat
import SwiftUI

class SubscriptionManager: ObservableObject {
    @Published var isPremium: Bool = false
    @Published var offerings: Offerings?

    init() {
        // Configure RevenueCat
        Purchases.configure(withAPIKey: "appl_kADUlQVYqqQCBQPNjYjfglNUHQp")
        checkSubscriptionStatus()
        fetchOfferings() // Fetch offerings on initialization
    }

    func checkSubscriptionStatus() {
        // Check the user's subscription status
        Purchases.shared.getCustomerInfo { [weak self] (customerInfo, error) in
            if let error = error {
                print("Error fetching customer info: \(error.localizedDescription)")
                self?.isPremium = false
                return
            }

            // Check if the user has any active entitlements
            if let isActive = customerInfo?.entitlements.all["premium"]?.isActive {
                DispatchQueue.main.async {
                    self?.isPremium = isActive
                }
            } else {
                self?.isPremium = false
            }
        }
    }

    func fetchOfferings() {
        Purchases.shared.getOfferings { [weak self] (offerings, error) in
            if let error = error {
                print("Error fetching offerings: \(error.localizedDescription)")
                return
            }
            self?.offerings = offerings
        }
    }

    func purchasePremium() {
        guard let package = offerings?.current?.availablePackages.first(where: { $0.identifier == "$rc_annual (Annual)" }) else {
            print("Premium package not found")
            return
        }

        // Function to initiate premium subscription purchase
        Purchases.shared.purchase(package: package) { [weak self] (transaction, customerInfo, error, userCancelled) in
            if let error = error {
                print("Error purchasing premium: \(error.localizedDescription)")
                return
            }

            // Successfully purchased, update the premium status
            self?.isPremium = customerInfo?.entitlements.all["premium"]?.isActive ?? false
        }
    }
}
