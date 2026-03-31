//
//  SubscriptionState.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import Foundation

public enum SubscriptionState: Equatable, Sendable {
    
    case none                           // never subscribed
    case active(expiresOn: Date)        // valid subscription
    case gracePeriod(until: Date)       // billing issue, still has access
    case expired                        // subscription lapsed
    case revoked                        // refund granted, access removed
    case lifetime                       // one-time purchase, never expires
    
    // MARK: - Helpers
    
    public var isActive: Bool {
        switch self {
        case .active, .gracePeriod, .lifetime:
            return true
        default:
            return false
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .none:
            return "No active subscription"
        case .active(let date):
            return "Active — renews \(date.formatted(date: .abbreviated, time: .omitted))"
        case .gracePeriod(let date):
            return "Billing issue — access until \(date.formatted(date: .abbreviated, time: .omitted))"
        case .expired:
            return "Subscription expired"
        case .revoked:
            return "Subscription refunded"
        case .lifetime:
            return "Lifetime access"
        }
    }
}
