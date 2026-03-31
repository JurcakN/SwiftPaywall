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
                .font(.title)
                .foregroundStyle(theme.primaryTextColor)
                .multilineTextAlignment(.center)
            
            Text(copy.subtitle)
                .font(.body)
                .foregroundStyle(theme.secondaryTextColor)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 40)
    }
}
