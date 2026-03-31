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
}
