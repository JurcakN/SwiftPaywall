//
//  PaywallCopy.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import Foundation

public struct PaywallCopy: Sendable {
    
    public var title: String
    public var subtitle: String
    public var ctaText: String
    public var restoreText: String
    public var cancelText: String
    public var privacyText: String
    public var termsText: String
    public var pendingText: String
    public var annualBadgeText: String
    
    public init(
        title: String = "Go Premium",
        subtitle: String = "Unlock all features",
        ctaText: String = "Get Started",
        restoreText: String = "Restore Purchases",
        cancelText: String = "Cancel anytime in App Store Settings",
        privacyText: String = "Privacy Policy",
        termsText: String = "Terms of Use",
        pendingText: String = "Purchase pending approval",
        annualBadgeText: String = "Best Value"
    ) {
        self.title = title
        self.subtitle = subtitle
        self.ctaText = ctaText
        self.restoreText = restoreText
        self.cancelText = cancelText
        self.privacyText = privacyText
        self.termsText = termsText
        self.pendingText = pendingText
        self.annualBadgeText = annualBadgeText
    }
    
    // MARK: - Builder-style customization
    
    public func withTitle(_ title: String) -> PaywallCopy {
        var copy = self
        copy.title = title
        return copy
    }
    
    public func withSubtitle(_ subtitle: String) -> PaywallCopy {
        var copy = self
        copy.subtitle = subtitle
        return copy
    }
    
    public func withCtaText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.ctaText = text
        return copy
    }
    
    public func withRestoreText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.restoreText = text
        return copy
    }
    
    public func withCancelText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.cancelText = text
        return copy
    }
    
    public func withPrivacyText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.privacyText = text
        return copy
    }
    
    public func withTermsText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.termsText = text
        return copy
    }
    
    public func withPendingText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.pendingText = text
        return copy
    }
    
    public func withAnnualBadgeText(_ text: String) -> PaywallCopy {
        var copy = self
        copy.annualBadgeText = text
        return copy
    }
}
