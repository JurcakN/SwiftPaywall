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
        backgroundColor: Color = .black,
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
}
