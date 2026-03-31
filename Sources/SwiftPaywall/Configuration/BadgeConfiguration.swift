//
//  BadgeConfiguration.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import Foundation

/// Defines which products should display a badge and what text to show
public struct BadgeConfiguration: Sendable {
    
    public let rule: BadgeRule
    
    public init(rule: BadgeRule = .annual) {
        self.rule = rule
    }
    
    // MARK: - Badge Rules
    
    public enum BadgeRule: Sendable {
        /// Show badge on annual products only
        case annual
        
        /// Show badge on monthly products only
        case monthly
        
        /// Show badge on lifetime products only
        case lifetime
        
        /// Show badge on specific product types
        case productTypes([PaywallProduct.ProductType])
        
        /// Show badge on specific product ID
        case productID(String)
        
        /// Show badge on multiple specific product IDs
        case productIDs([String])
        
        /// Custom rule - provide a closure that returns badge text for a product
        case custom(@Sendable (PaywallProduct) -> String?)
        
        /// Never show badge
        case none
    }
    
    // MARK: - Badge Text Resolution
    
    /// Returns the badge text for a given product, or nil if no badge should be shown
    public func badgeText(for product: PaywallProduct, defaultText: String) -> String? {
        switch rule {
        case .annual:
            return product.type == .annual ? defaultText : nil
            
        case .monthly:
            return product.type == .monthly ? defaultText : nil
            
        case .lifetime:
            return product.type == .lifetime ? defaultText : nil
            
        case .productTypes(let types):
            return types.contains(product.type) ? defaultText : nil
            
        case .productID(let id):
            return product.id == id ? defaultText : nil
            
        case .productIDs(let ids):
            return ids.contains(product.id) ? defaultText : nil
            
        case .custom(let closure):
            return closure(product)
            
        case .none:
            return nil
        }
    }
    
    // MARK: - Convenience Factory Methods
    
    /// Badge only on annual subscription
    public static var annual: BadgeConfiguration {
        BadgeConfiguration(rule: .annual)
    }
    
    /// Badge only on monthly subscription
    public static var monthly: BadgeConfiguration {
        BadgeConfiguration(rule: .monthly)
    }
    
    /// Badge only on lifetime purchase
    public static var lifetime: BadgeConfiguration {
        BadgeConfiguration(rule: .lifetime)
    }
    
    /// Badge on specific product types
    public static func productTypes(_ types: PaywallProduct.ProductType...) -> BadgeConfiguration {
        BadgeConfiguration(rule: .productTypes(types))
    }
    
    /// Badge on specific product ID
    public static func productID(_ id: String) -> BadgeConfiguration {
        BadgeConfiguration(rule: .productID(id))
    }
    
    /// Badge on specific product IDs
    public static func productIDs(_ ids: String...) -> BadgeConfiguration {
        BadgeConfiguration(rule: .productIDs(ids))
    }
    
    /// Custom badge logic with closure
    public static func custom(_ closure: @escaping @Sendable (PaywallProduct) -> String?) -> BadgeConfiguration {
        BadgeConfiguration(rule: .custom(closure))
    }
    
    /// No badge on any product
    public static var none: BadgeConfiguration {
        BadgeConfiguration(rule: .none)
    }
}
