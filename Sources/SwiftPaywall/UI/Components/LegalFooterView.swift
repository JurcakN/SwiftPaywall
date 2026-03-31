//
//  LegalFooterView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

public struct LegalFooterView: View {
    
    let theme: PaywallTheme
    let copy: PaywallCopy
    let configuration: PaywallConfiguration
    let onRestoreTap: () -> Void
    let onPrivacyTap: () -> Void
    let onTermsTap: () -> Void
    
    public init(
        theme: PaywallTheme,
        copy: PaywallCopy,
        configuration: PaywallConfiguration,
        onRestoreTap: @escaping () -> Void,
        onPrivacyTap: @escaping () -> Void,
        onTermsTap: @escaping () -> Void
    ) {
        self.theme = theme
        self.copy = copy
        self.configuration = configuration
        self.onRestoreTap = onRestoreTap
        self.onPrivacyTap = onPrivacyTap
        self.onTermsTap = onTermsTap
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            // Auto-renewal disclosure — required by Apple
            Text(copy.cancelText)
                .font(.caption)
                .foregroundStyle(theme.secondaryTextColor)
                .multilineTextAlignment(.center)
            
            // Legal links row
            HStack(spacing: 16) {
                Button(copy.restoreText, action: onRestoreTap)
                
                if case .none = configuration.privacyPolicy { } else {
                    Text("·").foregroundStyle(theme.secondaryTextColor)
                    Button(copy.privacyText, action: onPrivacyTap)
                }
                
                if case .none = configuration.terms { } else {
                    Text("·").foregroundStyle(theme.secondaryTextColor)
                    Button(copy.termsText, action: onTermsTap)
                }
            }
            .font(.caption)
            .foregroundStyle(theme.secondaryTextColor)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }
}
