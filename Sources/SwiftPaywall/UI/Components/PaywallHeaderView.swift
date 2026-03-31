//
//  PaywallHeaderView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

public struct PaywallHeaderView: View {
    
    let theme: PaywallTheme
    let copy: PaywallCopy
    
    public init(theme: PaywallTheme, copy: PaywallCopy) {
        self.theme = theme
        self.copy = copy
    }
    
    public var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "star.fill")
                .font(.system(size: 56))
                .foregroundStyle(theme.accentColor)
            
            Text(copy.title)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(theme.primaryTextColor)
            
            Text(copy.subtitle)
                .font(.title3)
                .foregroundStyle(theme.secondaryTextColor)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 40)
        .padding(.horizontal, 24)
    }
}
