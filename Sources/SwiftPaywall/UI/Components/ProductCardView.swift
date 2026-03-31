//
//  ProductCardView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

public struct ProductCardView: View {
    
    let product: PaywallProduct
    let isSelected: Bool
    let theme: PaywallTheme
    let copy: PaywallCopy
    let onSelect: () -> Void
    
    public init(
        product: PaywallProduct,
        isSelected: Bool,
        theme: PaywallTheme,
        copy: PaywallCopy,
        onSelect: @escaping () -> Void
    ) {
        self.product = product
        self.isSelected = isSelected
        self.theme = theme
        self.copy = copy
        self.onSelect = onSelect
    }
    
    public var body: some View {
        Button(action: onSelect) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(product.displayName)
                            .font(.headline)
                            .foregroundStyle(theme.primaryTextColor)
                        
                        if product.type == .annual {
                            Text(copy.annualBadgeText)
                                .font(.caption.bold())
                                .foregroundStyle(theme.ctaTextColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(theme.accentColor)
                                .clipShape(Capsule())
                        }
                        
                        if product.type == .lifetime {
                            Text("One-time")
                                .font(.caption.bold())
                                .foregroundStyle(theme.accentColor)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(theme.accentColor.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                    
                    if let perMonth = product.pricePerMonth, product.type == .annual {
                        Text(perMonth)
                            .font(.caption)
                            .foregroundStyle(theme.secondaryTextColor)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 2) {
                    Text(product.displayPrice)
                        .font(.headline)
                        .foregroundStyle(theme.primaryTextColor)
                    
                    if product.type == .monthly {
                        Text("/ month")
                            .font(.caption)
                            .foregroundStyle(theme.secondaryTextColor)
                    }
                    
                    if product.type == .annual {
                        Text("/ year")
                            .font(.caption)
                            .foregroundStyle(theme.secondaryTextColor)
                    }
                }
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? theme.accentColor : theme.secondaryTextColor)
                    .font(.title2)
                    .padding(.leading, 8)
            }
            .padding(16)
            .background(theme.cardBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: theme.cornerRadius)
                    .stroke(isSelected ? theme.accentColor : Color.clear, lineWidth: 2)
            )
        }
    }
}
