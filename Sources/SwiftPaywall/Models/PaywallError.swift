//
//  PaywallError.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import Foundation

public enum PaywallError: Error, LocalizedError, Sendable {
    
    case productLoadFailed(Error)
    case purchaseFailed(Error)
    case restoreFailed(Error)
    case verificationFailed
    case purchasePending
    case notEligibleForIntroOffer
    case unknown
    
    // MARK: - LocalizedError
    
    public var errorDescription: String? {
        switch self {
        case .productLoadFailed:
            return "Failed to load products. Please check your connection and try again."
        case .purchaseFailed:
            return "Purchase failed. Please try again."
        case .restoreFailed:
            return "Could not restore purchases. Please try again."
        case .verificationFailed:
            return "Purchase verification failed. Please contact support."
        case .purchasePending:
            return "Your purchase is pending approval."
        case .notEligibleForIntroOffer:
            return "You are not eligible for this introductory offer."
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .purchasePending:
            return "Ask purchaser to approve the request in their device."
        case .verificationFailed:
            return "Contact support if the issue persists."
        default:
            return nil
        }
    }
}
