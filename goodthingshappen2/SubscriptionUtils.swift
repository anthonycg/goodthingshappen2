//
//  checkSubscriptionStatus.swift
//  goodthingshappen2
//
//  Created by Anthony Gibson on 10/1/24.
//

import Foundation
import RevenueCat

// Global function to check premium status
func checkPremiumStatus() async -> Bool {
    do {
        let customerInfo = try await Purchases.shared.customerInfo()
        return customerInfo.entitlements.all["premium"]?.isActive == true
    } catch {
        print("Failed to check premium status: \(error)")
        return false
    }
}

