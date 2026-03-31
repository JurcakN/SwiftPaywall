//
//  PaywallTheme.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

public struct PaywallTheme: Sendable {
    
    public var accentColor: Color
    public var backgroundColor: Color
    public var primaryTextColor: Color
    public var secondaryTextColor: Color
    public var cardBackgroundColor: Color
    public var ctaTextColor: Color
    public var cornerRadius: CGFloat
    
    public init(
        accentColor: Color = .blue,
        backgroundColor: Color = .clear,
        primaryTextColor: Color = .white,
        secondaryTextColor: Color = .gray,
        cardBackgroundColor: Color = .white.opacity(0.1),
        ctaTextColor: Color = .white,
        cornerRadius: CGFloat = 16
    ) {
        self.accentColor = accentColor
        self.backgroundColor = backgroundColor
        self.primaryTextColor = primaryTextColor
        self.secondaryTextColor = secondaryTextColor
        self.cardBackgroundColor = cardBackgroundColor
        self.ctaTextColor = ctaTextColor
        self.cornerRadius = cornerRadius
    }
    
    // MARK: - Presets
    
    public static var dark: PaywallTheme {
        PaywallTheme() // defaults are already dark
    }
    
    public static var light: PaywallTheme {
        PaywallTheme(
            accentColor: .blue,
            backgroundColor: .white,
            primaryTextColor: .black,
            secondaryTextColor: .gray,
            cardBackgroundColor: .black.opacity(0.05),
            ctaTextColor: .white
        )
    }
    
    // MARK: - Builder-style customization
    
    public func withAccentColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.accentColor = color
        return theme
    }
    
    public func withBackgroundColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.backgroundColor = color
        return theme
    }
    
    public func withPrimaryTextColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.primaryTextColor = color
        return theme
    }
    
    public func withSecondaryTextColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.secondaryTextColor = color
        return theme
    }
    
    public func withCardBackgroundColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.cardBackgroundColor = color
        return theme
    }
    
    public func withCtaTextColor(_ color: Color) -> PaywallTheme {
        var theme = self
        theme.ctaTextColor = color
        return theme
    }
    
    public func withCornerRadius(_ radius: CGFloat) -> PaywallTheme {
        var theme = self
        theme.cornerRadius = radius
        return theme
    }
}
