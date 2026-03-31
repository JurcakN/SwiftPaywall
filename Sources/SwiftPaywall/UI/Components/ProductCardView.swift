//
//  ProductCardView.swift
//  SwiftPaywall
//
//  Created by Nicolas Jurcak on 31.03.2026.
//

import SwiftUI

struct ProductCardView: View {
    
    //MARK: - PROPERTIES
    let product: PaywallProduct
    let isSelected: Bool
    let theme: PaywallTheme
    let copy: PaywallCopy
    let onSelect: () -> Void
    
    //MARK: - INITIALIZATION
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
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.displayName)
                        .font(.headline)
                    
                    HStack(spacing: 0) {
                        Text(product.displayPrice)
                            .font(.subheadline)
                        
                        if product.type == .monthly {
                            Text(" / month")
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                        }
                        
                        if product.type == .annual {
                            Text(" / year")
                                .font(.caption)
                                .foregroundStyle(Color.secondary)
                        }
                    }
                }
                
                Spacer()
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(isSelected ? theme.accentColor : theme.secondaryTextColor)
            }
        }
        .padding(.horizontal)
        .frame(height: 75)
        .frame(maxWidth: .infinity)
        .background(Color.secondary.opacity(0.25), in: RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(theme.accentColor.gradient, lineWidth: 2)
                .opacity(isSelected ? 1 : 0)
        )
        .overlay(alignment: .topTrailing) {
            Text(copy.annualBadgeText)
                .font(.caption.bold())
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(theme.accentColor, in: Capsule())
                .offset(x: -20, y: -10)
        }
        .onTapGesture {
            onSelect()
        }
    }
}
