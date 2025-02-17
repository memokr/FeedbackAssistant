//
//  DataController-StoreKit.swift
//  FeedbackAssistant
//
//  Created by Guillermo Kramsky on 09/12/24.
//

import Foundation
import StoreKit

extension DataController {
    /// The product ID for the premium unlock.
    static let unlockPremiumproductID = "com.guillermokramsky.FeedbackAssistant.premiumUnlock"

    /// Loads and saves whether our premium unlock has been purchased.
    var fullVersionUnlocked: Bool {
        get {
            defaults.bool(forKey: "fullVersionUnlocked")
        } set {
            defaults.set(newValue, forKey: "fullVersionUnlocked")
        }
    }

    func monitorTransactions() async {
        // Check for previous purchases.
        for await entitlement in Transaction.currentEntitlements {
            if case let .verified(transaction) = entitlement {
                await finalize(transaction)
            }
        }

        // Watch for future transactions coming in
        for await update in Transaction.updates {
            if let transaction = try? update.payloadValue {
                await finalize(transaction)
            }
        }
    }
    
    @MainActor
    func finalize(_ transaction: Transaction) async {
        // Making sure the ID is the correct one
        if transaction.productID == Self.unlockPremiumproductID {
            // Advice a change will happen.
            objectWillChange.send()
            // If a refund has not been requested then equals true
            fullVersionUnlocked = transaction.revocationDate == nil
            // Call finish on the transaction
            await transaction.finish()
        }
    }

    @MainActor
    func loadProducts() async throws {
        guard products.isEmpty else { return }

        try await Task.sleep(for: .seconds(0.2))
        products = try await Product.products(for: [Self.unlockPremiumproductID])
    }
}
