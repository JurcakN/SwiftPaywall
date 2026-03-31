//
//  EntitlementManager.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import StoreKit

@MainActor
public final class EntitlementManager: ObservableObject, Sendable {
    
    @Published public var subscriptionState: SubscriptionState = .none
    @Published public var isSubscribed: Bool = false
    
    public init() {}
    
    // MARK: - Check entitlements
    
    public func refresh() async {
        var foundActive = false
        
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            
            switch transaction.productType {
            case .autoRenewable:
                foundActive = await handleAutoRenewable(transaction)
            case .nonConsumable:
                // lifetime purchase
                if !transaction.isRevoked {
                    foundActive = true
                    subscriptionState = .lifetime
                }
            default:
                break
            }
            
            if foundActive { break }
        }
        
        if !foundActive {
            subscriptionState = .none
            isSubscribed = false
        }
    }
    
    // MARK: - Private
    
    private func handleAutoRenewable(_ transaction: Transaction) async -> Bool {
        // Revoked — refund granted
        if transaction.revocationDate != nil {
            subscriptionState = .revoked
            isSubscribed = false
            return false
        }
        
        // Check expiry
        if let expiryDate = transaction.expirationDate {
            if expiryDate > Date.now {
                subscriptionState = .active(expiresOn: expiryDate)
                isSubscribed = true
                return true
            } else {
                // Check grace period via subscription status
                if let statuses = try? await Product.SubscriptionInfo.status(for: transaction.productID) {
                    for status in statuses {
                        if case .inGracePeriod = status.state {
                            subscriptionState = .gracePeriod(until: expiryDate)
                            isSubscribed = true
                            return true
                        }
                    }
                }
                subscriptionState = .expired
                isSubscribed = false
                return false
            }
        }
        return false
    }
}

// MARK: - Transaction extension
private extension Transaction {
    var isRevoked: Bool {
        revocationDate != nil
    }
}
