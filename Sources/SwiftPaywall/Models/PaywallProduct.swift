//
//  PaywallProduct.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import StoreKit

public struct PaywallProduct: Identifiable, Sendable {
    
    public let id: String
    public let product: Product
    public let type: ProductType
    
    // MARK: - Display helpers
    
    public var displayName: String {
        product.displayName
    }
    
    public var displayPrice: String {
        product.displayPrice
    }
    
    public var description: String {
        product.description
    }
    
    public var pricePerMonth: String? {
        guard let subscription = product.subscription else { return nil }
        let months = subscription.subscriptionPeriod.months
        guard months > 0 else { return nil }
        let monthly = product.price / Decimal(months)
        let formatted = product.priceFormatStyle.format(monthly)
        return "\(formatted)/mo"
    }
    
    // Move intro offer eligibility check to an async method — never use in body directly
    public func checkIntroEligibility() async -> Bool {
        guard let subscription = product.subscription else { return false }
        return await subscription.isEligibleForIntroOffer
    }
    
    public var introOfferLabel: String? {
        guard let offer = product.subscription?.introductoryOffer else { return nil }
        
        switch offer.paymentMode {
        case .freeTrial:
            return "\(offer.period.value) \(offer.period.unit.localizedDescription) free"
        case .payUpFront:
            return "\(offer.displayPrice) for \(offer.period.value) \(offer.period.unit.localizedDescription)"
        case .payAsYouGo:
            return "\(offer.displayPrice)/\(offer.period.unit.localizedDescription) for \(offer.periodCount) periods"
        default:
            return nil
        }
    }
    
    // MARK: - Product type
    
    public enum ProductType: Sendable {
        case monthly
        case annual
        case lifetime
        case weekly
        case other
    }
    
    // MARK: - Init
    
    public init(product: Product) {
        self.id = product.id
        self.product = product
        self.type = Self.resolveType(from: product)
    }
    
    // MARK: - Private
    
    private static func resolveType(from product: Product) -> ProductType {
        guard let subscription = product.subscription else {
            return .lifetime
        }
        
        let period = subscription.subscriptionPeriod
        
        switch period.unit {
        case .month where period.value == 1:  return .monthly
        case .year  where period.value == 1:  return .annual
        case .week  where period.value == 1:  return .weekly
        default:                              return .other
        }
    }
}

// MARK: - Period unit description
private extension Product.SubscriptionPeriod.Unit {
    var localizedDescription: String {
        switch self {
        case .day:    return "day"
        case .week:   return "week"
        case .month:  return "month"
        case .year:   return "year"
        @unknown default: return "period"
        }
    }
}

// MARK: - Period months helper
private extension Product.SubscriptionPeriod {
    var months: Int {
        switch unit {
        case .month:  return value
        case .year:   return value * 12
        case .week:   return 0
        case .day:    return 0
        @unknown default: return 0
        }
    }
}
