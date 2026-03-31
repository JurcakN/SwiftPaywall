//
//  PaywallConfiguration.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import Foundation

public struct PaywallConfiguration: Sendable {
    
    public var productIDs: [String]
    public var theme: PaywallTheme
    public var copy: PaywallCopy
    public var privacyPolicy: LegalLinkDestination
    public var terms: LegalLinkDestination
    
    public init(
        productIDs: [String],
        theme: PaywallTheme = .dark,
        copy: PaywallCopy = PaywallCopy(),
        privacyPolicy: LegalLinkDestination = .none,
        terms: LegalLinkDestination = .none
    ) {
        self.productIDs = productIDs
        self.theme = theme
        self.copy = copy
        self.privacyPolicy = privacyPolicy
        self.terms = terms
    }
    
    // MARK: - Builder-style customization
    
    public func withTheme(_ theme: PaywallTheme) -> PaywallConfiguration {
        var config = self
        config.theme = theme
        return config
    }
    
    public func withCopy(_ copy: PaywallCopy) -> PaywallConfiguration {
        var config = self
        config.copy = copy
        return config
    }
    
    public func withPrivacyPolicy(_ policy: LegalLinkDestination) -> PaywallConfiguration {
        var config = self
        config.privacyPolicy = policy
        return config
    }
    
    public func withPrivacyPolicyURL(_ url: URL) -> PaywallConfiguration {
        var config = self
        config.privacyPolicy = .url(url)
        return config
    }
    
    public func withTerms(_ terms: LegalLinkDestination) -> PaywallConfiguration {
        var config = self
        config.terms = terms
        return config
    }
    
    public func withTermsURL(_ url: URL) -> PaywallConfiguration {
        var config = self
        config.terms = .url(url)
        return config
    }
}
